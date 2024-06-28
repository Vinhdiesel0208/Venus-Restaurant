package com.mytech.restaurantportal.controllers;

import com.mytech.restaurantportal.mailer.EmailService;
import com.restaurant.service.entities.Contact;
import com.restaurant.service.services.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.mail.MessagingException;
import jakarta.validation.Valid;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/contacts")
public class ContactController {
    private String defaultRedirectURL = "redirect:/contacts/page/1?sortField=title&sortDir=asc";
    
    @Autowired
    private ContactService contactService;

    @Autowired
    private EmailService emailService;

    @GetMapping("")
    public String showContactForm(Model model) {
        List<Contact> contacts = contactService.getAllContacts();
        model.addAttribute("contacts", contacts);
        return "apps/contacts/contact"; 
    }

    @PostMapping("/contact")
    public String submitContactForm(@Valid @ModelAttribute("contact") Contact contact, BindingResult result, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "apps/contacts/contact";
        }

        contact.setCreatedTime(LocalDateTime.now());
        contactService.registerContact(contact);
      
        redirectAttributes.addFlashAttribute("successMessage", "Your message has been sent successfully!");
        return defaultRedirectURL; 
    }

 



    @PostMapping("/respond/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> sendAdminResponse(@PathVariable("id") Long id, @RequestParam("responseMessage") String responseMessage) {
        Map<String, String> response = new HashMap<>();
        try {
            Contact updatedContact = contactService.sendResponse(id, responseMessage);
            if (updatedContact != null) {
                sendAdminResponseEmail(updatedContact, responseMessage); // Modified to use Thymeleaf template
                
                response.put("message", "Your message has been sent successfully to the customer.");
                return ResponseEntity.ok(response);
            } else {
                response.put("message", "Failed to send response to customer.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
        } catch (Exception e) {
            response.put("message", "An error occurred while processing your request.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    private void sendAdminResponseEmail(Contact contact, String responseMessage) {
        String to = contact.getEmail();
        String subject = "Response to Your Message";
        Map<String, Object> templateModel = new HashMap<>();
        templateModel.put("name", contact.getFullName());
        templateModel.put("responseMessage", responseMessage);
        templateModel.put("logo", "mail-logo.png"); // Make sure you have a corresponding resource

        try {
            emailService.sendMessageUsingThymeleafTemplate(to, subject, templateModel);
        } catch (IOException | MessagingException e) {
            // Log the exception or handle it according to your error handling policy
            e.printStackTrace();
        }

    }
}
