package com.mytech.restaurantportal.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mytech.restaurantportal.mailer.EmailService;
import com.restaurant.service.entities.BookingTable;
import com.restaurant.service.entities.Reservation;
import com.restaurant.service.entities.TableM;
import com.restaurant.service.services.ReservationService;
import com.restaurant.service.services.TableMService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/reservation")
public class BookingTableController {
	@Autowired
	private ReservationService reservationService;

	@Autowired
	private TableMService tableMService;

	@Autowired
	private EmailService emailService;

	@GetMapping("/reservationInfo")
	public String showReservationData(@RequestParam(name = "date", required = false) String date, Model model) {
		System.out.println("Date RAW:" + date);
		if (date == null || date.isEmpty()) {
			date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		}
		System.out.println("Date Formatter:" + date);
		List<Object[]> reservationData = reservationService.getReservationDataByDate(date);
		model.addAttribute("reservationData", reservationData);
		model.addAttribute("date", date);
		return "apps/booktable/reservationInfo";
	}

	@GetMapping("/search")
	public String search(@ModelAttribute("bookingTable") BookingTable bookingTable, Model model) {
		List<BookingTable> searchList = reservationService.search(bookingTable);
		model.addAttribute("reList", searchList);
		return "/apps/booktable/list";
	}

	@GetMapping("/list")
	public String viewList(Model model) {
		List<BookingTable> reList = reservationService.getAll();
		Collections.reverse(reList);
		model.addAttribute("bookingTable", new BookingTable());
		model.addAttribute("reList", reList);
		return "/apps/booktable/list";
	}

	@GetMapping("/listApprove")
	public String viewListApprove(Model model) {
		List<Reservation> appList = reservationService.getAllApprove();
		Collections.reverse(appList);
		model.addAttribute("appList", appList);
		return "/apps/booktable/list_approve";
	}

	@GetMapping("/showFormForApprove/{id}")
	public String showForm(@PathVariable(value = "id") Long id, @RequestParam("personNumber") Integer personNumber,
			@RequestParam("date") String date, @RequestParam("start_time") String start_time,
			@RequestParam("end_time") String end_time, Model model, RedirectAttributes redirectAttributes) {
		try {
			BookingTable bookingTable = reservationService.getById(id);
			if (bookingTable.getStatus() == 1 || bookingTable.getStatus() == 2) {
				redirectAttributes.addFlashAttribute("message", "This application has been approved");
				return "redirect:/reservation/list";
			}
			// reservation.setDate(date);
			// Date dateToString = DateUtils.parseStringToDate(date);
			model.addAttribute("bookingTable", bookingTable);
			List<TableM> listTable = tableMService.listTableByPerson(personNumber, date, start_time, end_time);
			model.addAttribute("listTable", listTable);
			System.out.println("listTable:" + listTable);
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		}

		return "/apps/booktable/approve";
	}

	@PostMapping("/approve")
	public String approve(@Valid @ModelAttribute("reservation") BookingTable bookingTable, HttpServletRequest request,
			@RequestParam("tableId") Long tableId, RedirectAttributes redirectAttributes, BindingResult result,
			Model model) throws ParseException {
		if (result.hasErrors()) {
			return "apps/booktable/approve";
		}

		String action = request.getParameter("action");
		List<TableM> listTable = tableMService.listTableByPerson(bookingTable.getPerson_number(),
				bookingTable.getDate(), bookingTable.getStart_time(),bookingTable.getEnd_time());
		BookingTable bookingTable1 = reservationService.getById(bookingTable.getId());
		if ("Approve".equals(action)) {
			if (result.hasErrors()) {
				return "apps/booktable/approve";
			}
			if (tableId == null || tableId == 0L) {
				redirectAttributes.addFlashAttribute("errorMessage", "Please select a table.");
				redirectAttributes.addFlashAttribute("listTable", listTable);
				System.out.println("listTable:" + listTable);
				return "redirect:/reservation/showFormForApprove/" + bookingTable.getId() + "?personNumber="
						+ bookingTable.getPerson_number() + "&date=" + bookingTable.getDate() + "&time="
						+ bookingTable.getStart_time();
			}

			bookingTable1.setStatus(1);
			TableM tableM = tableMService.get(tableId);
			reservationService.save(bookingTable1);
			reservationService.saveApprove(bookingTable, tableM);

			// Map data template
			Map<String, Object> templateModel = Map.of("name", bookingTable1.getName(), "date", bookingTable1.getDate(),
					"time", bookingTable1.getStart_time(), "email", bookingTable1.getEmail(), "table_name",
					tableM.getName_table());

			// Send email to customer
			emailService.sendHtmlMessage(bookingTable1.getEmail(), "[VENUS Restaurant]_Notice About Table Reservations",
					templateModel, "apps/emails/emailAccepted");

			redirectAttributes.addFlashAttribute("successMessage", "Approved successfully!");
			return "redirect:/reservation/list";
		} else if ("Refuse".equals(action)) {

			if (listTable.isEmpty()) {
				bookingTable1.setStatus(2);
				reservationService.save(bookingTable1);
				// Map data template
				Map<String, Object> templateModel = Map.of("name", bookingTable1.getName(), "date",
						bookingTable1.getDate(), "time", bookingTable1.getStart_time());

				// Send email to customer
				emailService.sendHtmlMessage(bookingTable1.getEmail(),
						"[VENUS Restaurant]_Notice About Table Reservations", templateModel,
						"apps/emails/rejectionEmail");
				redirectAttributes.addFlashAttribute("successMessage", "Refuse successfully!");
				return "redirect:/reservation/list";
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "There are still empty tables");
				redirectAttributes.addFlashAttribute("listTable", listTable);
				System.out.println("listTable:" + listTable);
				return "redirect:/reservation/showFormForApprove/" + bookingTable.getId() + "?personNumber="
						+ bookingTable.getPerson_number() + "&date=" + bookingTable.getDate() + "&time="
						+ bookingTable.getStart_time();
			}

		}
		return "apps/booktable/list";

	}

	@GetMapping("/listTable")
	public String viewListTable(Model model) {
		List<TableM> tableList = tableMService.listAll();
		model.addAttribute("tableList", tableList);
		return "/apps/booktable/list_table";
	}

	@GetMapping("/addTable")
	public String viewAdd(Model model) {
		TableM tableM = new TableM();
		model.addAttribute("tableM", tableM);
		return "/apps/booktable/add_table";
	}

	@PostMapping("/saveTable")
	public String saveTable(@Valid @ModelAttribute("tableM") TableM table, BindingResult bindingResult, Model model,
			RedirectAttributes redirectAttributes) {
		if (bindingResult.hasErrors()) {
			return "apps/booktable/add_table";
		}

		TableM existingTable = tableMService.findByTableName(table.getName_table());
		if (existingTable != null) {
			redirectAttributes.addFlashAttribute("errorMessage", "Table name already exists!!");
			return "redirect:/reservation/addTable";
		}

		tableMService.save(table);
		redirectAttributes.addFlashAttribute("successMessage", "Table added successfully!");
		return "redirect:/reservation/listTable";
	}

}
