package com.mytech.RestaurantsWeb.controller;

import java.math.BigDecimal;
import java.text.ParseException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mytech.RestaurantsWeb.helpers.AppHelper;
import com.mytech.RestaurantsWeb.mailer.EmailService;
import com.mytech.RestaurantsWeb.payments.paypal.PaypalPaymentIntent;
import com.mytech.RestaurantsWeb.payments.paypal.PaypalPaymentMethod;
import com.mytech.RestaurantsWeb.payments.paypal.PaypalService;
import com.mytech.RestaurantsWeb.payments.vnpay.VnPayService;
import com.mytech.RestaurantsWeb.security.AppUserDetails;
import com.mytech.RestaurantsWeb.utils.DateTimeConverterUtil;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import com.restaurant.service.entities.BookingTable;
import com.restaurant.service.entities.CartLine;
import com.restaurant.service.entities.Customer;
import com.restaurant.service.entities.FCategory;
import com.restaurant.service.entities.Ingredient;
import com.restaurant.service.entities.RestaurantTable;
import com.restaurant.service.repositories.BookingTableRepository;
import com.restaurant.service.repositories.CustomerRepository;
import com.restaurant.service.services.ReservationService;
import com.restaurant.service.services.RestaurantTableService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/booktable")
public class BookingController {
	@Autowired
	private EmailService emailService;

	@Autowired
	private VnPayService vnPayService;

	@Autowired
	private PaypalService paypalService;

	@Autowired
	private ReservationService reservationService;

	@Autowired
	private CustomerRepository customerRepository;

	@Autowired
	private RestaurantTableService restaurantTableService;

	public static final String PAYPAL_SUCCESS_URL = "success";
	public static final String PAYPAL_CANCEL_URL = "checkout";
	private Logger log = LoggerFactory.getLogger(getClass());

	@GetMapping("/add")
	public String viewCreate(Model model, @AuthenticationPrincipal AppUserDetails loggedUser) {
		Long cusId = loggedUser.getId();
		Optional<Customer> cusOptional = customerRepository.findById(cusId);

		BookingTable bookingTable = new BookingTable();
		if (cusOptional.isPresent()) {
			Customer cus = cusOptional.get();
			bookingTable.setName(cus.getFullName());
			bookingTable.setEmail(cus.getEmail());
			bookingTable.setPhone_number(cus.getPhoneNumber());
			model.addAttribute("cus", cus);
		} else {
			model.addAttribute("cus", new Customer());
		}
		model.addAttribute("bookingTable", bookingTable);
		return "bookingtable";
	}

	@GetMapping("/findtable")
	public String findTable(@Valid @ModelAttribute("bookingTable") BookingTable bookingTable, Model model,
			BindingResult bindingResult) throws ParseException {
		if (bindingResult.hasErrors()) {
			return "bookingtable";
		}
		String startTimeStr = bookingTable.getStart_time();
		String endTimeStr = bookingTable.getEnd_time();
		LocalTime startTime = LocalTime.parse(startTimeStr);
		LocalTime endTime = LocalTime.parse(endTimeStr);

		// Kiểm tra end-time phải lớn hơn start-time và không lớn hơn 4 giờ
		long hoursBetween = Duration.between(startTime, endTime).toHours();
		if (hoursBetween <= 0 || hoursBetween > 4) {
			model.addAttribute("error", "End-time must be greater than Start-time and not greater than 4 hours.");
			return "bookingtable";
		}

		List<RestaurantTable> listTable = restaurantTableService.listTableByPerson(bookingTable.getPerson_number(),
				bookingTable.getDate(), bookingTable.getStart_time(), bookingTable.getEnd_time());

		LocalDateTime dateTime = DateTimeConverterUtil.convertStringToDateTime(bookingTable.getDate(),
				bookingTable.getStart_time());
		LocalDateTime now = LocalDateTime.now();
		if (dateTime.isBefore(now.plusHours(3))) {
			model.addAttribute("error", "Table reservation time must be 3 hours more than the current time");
			return "bookingtable";
		}
		//Display date
		String dateFormat = DateTimeConverterUtil.formatDate(bookingTable.getDate());
		model.addAttribute("dateFormat", dateFormat);
		
		model.addAttribute("listTable", listTable);
		model.addAttribute("bookingTable", bookingTable);
		return "findtable";
	}

	@GetMapping("/checkout")
	public String viewCheckout(Model model, @ModelAttribute("bookingTable") BookingTable bookingTable,
			HttpSession session) {
		RestaurantTable table = restaurantTableService
				.getRestaurantTableById(bookingTable.getTableId());
		model.addAttribute("table", table);
		session.setAttribute("bookingTable", bookingTable);
		return "checkout-bookingtable";
	}

	@PostMapping("/process")
	public String processCheckout(@ModelAttribute("bookingTable") BookingTable bookingTable,
			@RequestParam("pay-method") String paymentMethod, RedirectAttributes redirectAttributes,
			HttpServletRequest request, Model model) {
		RestaurantTable restaurantTable = restaurantTableService
				.getRestaurantTableById(bookingTable.getTableId());
		model.addAttribute("table", restaurantTable);
		model.addAttribute("bookingTable", bookingTable);
		
		redirectAttributes.addFlashAttribute("bookingTable", bookingTable);
		
		// Thanh toán PayPal
		if ("paypal".equals(paymentMethod)) {
			String cancelUrl = AppHelper.getSiteURL(request) + "/" + PAYPAL_CANCEL_URL;
			String successUrl = AppHelper.getSiteURL(request) + "/" + PAYPAL_SUCCESS_URL + "?email="
					+ bookingTable.getEmail();
			try {
				Payment payment = paypalService.createPayment(restaurantTable.getPrice(), "USD",
						PaypalPaymentMethod.PAYPAL, PaypalPaymentIntent.ORDER, "payment description", cancelUrl,
						successUrl);
				for (Links links : payment.getLinks()) {
					if (links.getRel().equals("approval_url")) {
						return "redirect:" + links.getHref();
					}
				}
			} catch (PayPalRESTException e) {
				System.out.println(e.getMessage());
				log.error(e.getMessage());
			}
		}
		// Thanh toán VnPay
		else if ("vnpay".equals(paymentMethod)) {
			String returnUrl = AppHelper.getSiteURL(request) + "/booktable/vnpay-return";
			try {
				String paymentUrl = vnPayService.createPaymentUrl(restaurantTable.getPrice(), "payment description",
						returnUrl);
				return "redirect:" + paymentUrl;
			} catch (Exception e) {
				System.out.println(e.getMessage());
				log.error(e.getMessage());
			}
		}
		return "redirect:/success?email=" + bookingTable.getEmail();
	}

	@GetMapping("/vnpay-return")
	public String vnPayReturn(@RequestParam Map<String, String> params, Model model) {
		String vnp_ResponseCode = params.get("vnp_ResponseCode");
		if ("00".equals(vnp_ResponseCode)) {
			// Payment success
			model.addAttribute("message", "Click Done to complete!");
			return "success-bookingtable";
		} else {
			// Payment failed
			model.addAttribute("message", "Payment failed!");
			return "failure";
		}
	}

	@PostMapping("/add")
	public String create(HttpSession session, RedirectAttributes redirectAttributes) {
		BookingTable bookingTable = (BookingTable) session.getAttribute("bookingTable");

		if (bookingTable != null) {
			Long tableId = bookingTable.getTableId();
			RestaurantTable restaurantTable = restaurantTableService.getRestaurantTableById(tableId);
			//bookingTable.setRestaurantTable(restaurantTable);
			reservationService.save(bookingTable);

			// Map data
			Map<String, Object> templateModel = Map.of("name", bookingTable.getName(), "date", bookingTable.getDate(),
					"time", bookingTable.getStart_time(), "email", bookingTable.getEmail(), "table_name",
					restaurantTable.getTableNumber());
			// Send email to customer
			emailService.sendHtmlMessage(bookingTable.getEmail(), "[VENUS Restaurant]_Notice About Table Reservations",
					templateModel, "email/emailAccepted");

			redirectAttributes.addFlashAttribute("message", "Book a table successfully");
		}
		return "redirect:/booktable/add";
	}
}
