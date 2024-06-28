package com.mytech.restaurantportal.apis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.restaurant.service.dtos.ContactDTO;
import com.restaurant.service.entities.Contact;
import com.restaurant.service.services.ContactService;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/apis/v1/contacts")
public class ContactRestController {

    @Autowired
    private ContactService contactService;

    @PostMapping
    public ResponseEntity<ContactDTO> createContact(@RequestBody ContactDTO contactDTO) {
        System.out.println("Received contactDTO: " + contactDTO.toString());
        Contact contact = new Contact(contactDTO.getFullName(), contactDTO.getEmail(), contactDTO.getPhone(), contactDTO.getMessage(), LocalDateTime.now(), null);
        Contact savedContact = contactService.registerContact(contact);
        return ResponseEntity.ok(convertToDto(savedContact));
    }

    @GetMapping
    public List<ContactDTO> getAllContacts() {
        return contactService.getAllContacts().stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    private ContactDTO convertToDto(Contact contact) {
        ContactDTO contactDTO = new ContactDTO();
        contactDTO.setId(contact.getId());
        contactDTO.setFullName(contact.getFullName());
        contactDTO.setEmail(contact.getEmail());
        contactDTO.setPhone(contact.getPhone());
        contactDTO.setMessage(contact.getMessage());
        contactDTO.setCreatedTime(contact.getCreatedTime());
        contactDTO.setAdminResponse(contact.getAdminResponse());
        return contactDTO;
    }
}
