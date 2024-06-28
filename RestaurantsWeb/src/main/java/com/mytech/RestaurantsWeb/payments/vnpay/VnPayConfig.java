package com.mytech.RestaurantsWeb.payments.vnpay;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class VnPayConfig {

    @Value("${vnpay.terminalId}")
    private String vnpTmnCode;

    @Value("${vnpay.hashSecret}")
    private String vnpHashSecret;

    @Value("${vnpay.paymentUrl}")
    private String vnpUrl;

    // Getters for the fields
    public String getVnpTmnCode() {
        return vnpTmnCode;
    }

    public String getVnpHashSecret() {
        return vnpHashSecret;
    }

    public String getVnpUrl() {
        return vnpUrl;
    }
}
