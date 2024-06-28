class Endpoint {
  //Địa chỉ IP và cổng cho các endpoint chính
  static const String baseUrl = 'http://172.16.2.150:8082/apis/v1';
  static const String baseUrlTest = 'http://172.16.2.150:8082/apis/test';
  static const String baseUrl2 = 'http://172.16.2.150:8083/apis/v1';
  //hao
  static const String baseUr2 = 'http://172.16.2.150:8082/apis/v1/customers';

  static const String register = '$baseUr2/register';
  static const String forgotPassword = '$baseUr2/forgot-password';
  static const String resetPassword = '$baseUr2/reset-password';
  static const String userDetails = '$baseUr2/user_detail';
  static const String updateUser = '$baseUr2/update_user';
  static const String changePassword = '$baseUr2/change_password';
  static const String getAllCustomers = '$baseUr2/customer';
  static const String signin = '$baseUr2/signin';

  static const String signIn = '$baseUrl/signin';
  static const String signUp = '$baseUrl/signup';
  static const String users = '$baseUrl/users';

  // vinh
  static const String getContacts = '$baseUrl/contacts';
  static const String getPosts = '$baseUrl/posts';
  static const String chefDishes = '$baseUrl/chef/dishes';
  static const String updateCartLineStatus = '$baseUrl/chef/updateStatus';
  static const String updateCartLineQuantity =
      '$baseUrl/chef/updateCartLineQuantity';
  static const String deleteCartLine = '$baseUrl/chef/cartLine';
  static const String getTables = '$baseUrl/tables/list';
  // Endpoint cho checkin và checkout
  static const String checkinTable = '$baseUrl/tables';
  static const String checkoutTable = '$baseUrl/tables';
  // Thêm endpoint cho addToCart
  static const String addToCart = '$baseUrl/chef/addToCart';
  static const String staffCartLines = '$baseUrl/chef/cartLines';

  // VNPay và PayPal
  static const String paypalPayment = '$baseUrl/payment/paypal';
  static const String vnpayPayment = '$baseUrl/payment/vnpay';
//doi diem
  static const String getCustomerByEmail = '$baseUrl/customer/get';
  static const String redeemPoints = '$baseUrl/customer/redeem-points';
  static const String updatePoints = '$baseUrl/customer/update-points';
  static const String updatePointsAndSendEmail =
      '$baseUrl/customer/update-points-and-send-email';

  // tien

  static const String getIngredients = '$baseUrl/ingredients';
  static const String getIngredientById = '$baseUrl/ingredients/{id}';
  // phuoc
  static const String addBookingTable = '$baseUrl/bookingtable/add';
  static const String listTableByPerson = '$baseUrl2/bookingtable/tablelist';
}
