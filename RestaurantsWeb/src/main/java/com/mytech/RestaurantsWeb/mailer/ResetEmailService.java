package com.mytech.RestaurantsWeb.mailer;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class ResetEmailService {

	@Autowired
	private JavaMailSender mailSender;

	public void sendPasswordResetEmail(String to, String resetUrl) {
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);

		try {
			helper.setTo(to);
			helper.setSubject("[Venus] link to reset your password");
			helper.setText("<p>To reset your password, click the link below:</p>" + "<a href=\"" + resetUrl
					+ "\">Reset Password</a>" + "<p> noreply@venus.com</p>", true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
			// Handle exception
		}
	}
}

