package com.mytech.restaurantportal.payments;

import org.springframework.stereotype.Service;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

@Service
public class VnPayService {

    private static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private static final String VNP_TMNCODE = "RUPA4Z50";
    private static final String VNP_HASHSECRET = "D3A3WRJJ2HDV3ZEICH9L60VTSQZ1RZLB";

    public String createPaymentUrl(double amount, String description, String returnUrl) throws Exception {
        SortedMap<String, String> params = new TreeMap<>();
        params.put("vnp_Version", "2.1.0");
        params.put("vnp_Command", "pay");
        params.put("vnp_TmnCode", VNP_TMNCODE);
        params.put("vnp_Amount", String.valueOf((int) (amount * 2450000))); // amount in VND
        params.put("vnp_CurrCode", "VND");
        params.put("vnp_TxnRef", String.valueOf(System.currentTimeMillis()));
        params.put("vnp_OrderInfo", description);
        params.put("vnp_OrderType", "other");
        params.put("vnp_Locale", "vn");
        params.put("vnp_ReturnUrl", returnUrl);
        params.put("vnp_IpAddr", "192.168.1.156");//thay ip
        params.put("vnp_CreateDate", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

        // Tạo chuỗi để mã hóa HMAC-SHA512
        StringBuilder hashData = new StringBuilder();
        Set<Map.Entry<String, String>> entries = params.entrySet();
        for (Map.Entry<String, String> entry : entries) {
            if (hashData.length() > 0) {
                hashData.append('&');
            }
            hashData.append(entry.getKey());
            hashData.append('=');
            hashData.append(URLEncoder.encode(entry.getValue(), StandardCharsets.US_ASCII.toString()));
        }

        // In ra chuỗi hashData để debug
        System.out.println("hashData: " + hashData.toString());

        // Mã hóa HMAC-SHA512
        String hashString = hmacSHA512(VNP_HASHSECRET, hashData.toString());

        // In ra hashString để debug
        System.out.println("hashString: " + hashString);

        params.put("vnp_SecureHashType", "HMACSHA512");
        params.put("vnp_SecureHash", hashString);

        // Tạo URL query string
        StringBuilder query = new StringBuilder();
        for (Map.Entry<String, String> param : params.entrySet()) {
            if (query.length() > 0) {
                query.append('&');
            }
            query.append(param.getKey());
            query.append('=');
            query.append(URLEncoder.encode(param.getValue(), StandardCharsets.UTF_8.toString()));
        }

        // In ra URL đầy đủ để debug
        String fullUrl = VNP_URL + "?" + query.toString();
        System.out.println("Full URL: " + fullUrl);

        return fullUrl;
    }

    private static String hmacSHA512(String key, String data) throws Exception {
        Mac hmacSHA512 = Mac.getInstance("HmacSHA512");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        hmacSHA512.init(secretKey);
        byte[] hashBytes = hmacSHA512.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder hashString = new StringBuilder();
        for (byte hashByte : hashBytes) {
            hashString.append(String.format("%02x", hashByte));
        }
        return hashString.toString();
    }
}
