package com.mytech.RestaurantsWeb.helpers;

public class AppConstant {
    // ROLES
	public static final String STAFF = "STAFF";
//    public static final String baseUrl = "http://192.168.1.221:8083"; 
    public static final String baseUrl = "http://172.16.2.150:8083"; 
    public static final String imageUrl =  baseUrl + "/files/";

    // API Endpoints
    public static final String PAYPAL_PAYMENT_URL = baseUrl + "/payment/paypal";
    public static final String VNPAY_PAYMENT_URL = baseUrl + "/payment/vnpay";
    public static final String PAYPAL_SUCCESS_URL = baseUrl + "/payment/paypal/success";
    public static final String PAYPAL_CANCEL_URL = baseUrl + "/payment/paypal/cancel";
    public static final String VNPAY_RETURN_URL = baseUrl + "/payment/vnpay-return";
    
    
    //hap 19.6
 // ROLES
  	public static final String CUS = "CUS";
     public static final String emptyString = "";
 	public static final int pageCount = 15;
     //public static final String baseUrl2 = "http://192.168.1.221:8082";
     public static final String baseUrl2 = "http://172.16.2.150:8082";
     public static final String APIS = "/apis/v1/";
     
     // API Endpoints
  	public static final String REGISTER_VIEW = baseUrl2 + "/customers/register";
     public static final String REGISTER = baseUrl2 + "/customers/register";
     public static final String FORGOT_PASSWORD_VIEW = baseUrl2 + "/customers/forgot-password";
     public static final String FORGOT_PASSWORD = baseUrl2 + "/customers/forgot-password";
     public static final String RESET_PASSWORD_VIEW = baseUrl2 + "/customers/reset-password";
     public static final String RESET_PASSWORD = baseUrl2 + "/customers/reset-password";
     public static final String USER_DETAIL = baseUrl2 + "/customers/user_detail";
     public static final String UPDATE_USER = baseUrl2 + "/customers/update_user";
     public static final String CHANGE_PASSWORD = baseUrl2 + "/customers/change_password";
     public static final String GET_ALL_CUSTOMERS = baseUrl2 + "/customers/customer";
     public static final String CREATE_CUSTOMER = baseUrl2 + "/customers/create";
     public static final String DELETE_CUSTOMER = baseUrl2 + "/customers/{customerId}";
     public static final String SIGNIN = baseUrl2 + "/customers/signin";
     
}
