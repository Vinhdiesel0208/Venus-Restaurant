package com.mytech.RestaurantsWeb.mailer;

import java.util.Map;

public interface EmailService {
    void sendSimpleMessage(String to, String subject, String text);
    void sendHtmlMessage(String to, String subject, Map<String, Object> model, String templateName);
}
