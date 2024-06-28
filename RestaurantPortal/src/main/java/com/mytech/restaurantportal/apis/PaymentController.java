package com.mytech.restaurantportal.apis;

import com.mytech.restaurantportal.helpers.AppConstant;
import com.mytech.restaurantportal.payments.PaypalPaymentIntent;
import com.mytech.restaurantportal.payments.PaypalPaymentMethod;
import com.mytech.restaurantportal.payments.PaypalService;
import com.mytech.restaurantportal.payments.VnPayService;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.Map;

@RestController
@RequestMapping("/apis/v1/payment")
@CrossOrigin(origins = "http://localhost:8083")
public class PaymentController {

    @Autowired
    private VnPayService vnPayService;

    @Autowired
    private PaypalService paypalService;

    
    @PostMapping("/vnpay")
    public ResponseEntity<?> createVNPayPaymentUrl(@RequestBody Map<String, Object> payload) {
        try {
            double amount = Double.parseDouble(payload.get("amount").toString());
            String description = payload.get("description").toString();
            String returnUrl = AppConstant.baseUrl + "/payment/vnpay-return";
            String paymentUrl = vnPayService.createPaymentUrl(amount, description, returnUrl);
            return ResponseEntity.ok(Collections.singletonMap("url", paymentUrl));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    
    @PostMapping("/paypal")
    public ResponseEntity<?> createPayPalPaymentUrl(@RequestBody Map<String, Object> payload) {
        try {
            double amount = Double.parseDouble(payload.get("amount").toString());
            String description = payload.get("description").toString();
            String cancelUrl = AppConstant.baseUrl + "/payment/paypal/cancel";
            String successUrl = AppConstant.baseUrl + "/payment/paypal/success";
            Payment payment = paypalService.createPayment(amount, "USD", PaypalPaymentMethod.PAYPAL, PaypalPaymentIntent.ORDER, description, cancelUrl, successUrl);
            for (com.paypal.api.payments.Links links : payment.getLinks()) {
                if (links.getRel().equals("approval_url")) {
                    return ResponseEntity.ok(Collections.singletonMap("url", links.getHref()));
                }
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to create PayPal payment URL");
        } catch (PayPalRESTException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/paypal/cancel")
    public ResponseEntity<String> handlePayPalCancel() {
        return ResponseEntity.ok("Payment cancelled");
    }

    @GetMapping("/paypal/success")
    public ResponseEntity<String> handlePayPalSuccess(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId) {
        try {
            Payment payment = paypalService.executePayment(paymentId, payerId);
            return ResponseEntity.ok("Payment successful");
        } catch (PayPalRESTException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Payment failed");
        }
    }

    @GetMapping("/vnpay-return")
    public ResponseEntity<String> handleVNPayReturn(HttpServletRequest request) {
        Map<String, String[]> params = request.getParameterMap();
        for (Map.Entry<String, String[]> entry : params.entrySet()) {
            System.out.println(entry.getKey() + ": " + String.join(", ", entry.getValue()));
        }
        return ResponseEntity.ok("Payment successful");
    }
}
