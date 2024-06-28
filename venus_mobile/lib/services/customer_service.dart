import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/apis/endpoint.dart';

class CustomerService {
  Future<String> loginWebAccount(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(Endpoint.signin);
    Map body = {'email': email, 'password': password};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('fullName', json['fullName']);
      prefs.setString('email', json['email']);
      String role = json['roles'] != null ? json['roles'][0] : 'CUS';
      prefs.setString('role', role);
      return role;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid email or password');
    } else if (response.statusCode == 404) {
      throw Exception('Email not found');
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<void> registerCustomer(
      String fullName, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(Endpoint.register);
    Map body = {'fullName': fullName, 'email': email, 'password': password};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  Future<void> forgotPassword(String email) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(Endpoint.forgotPassword);
    Map body = {'email': email};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception('Failed to process forgot password');
    }
  }

  Future<void> resetPassword(
      String token, String newPassword, String confirmPassword) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(Endpoint.resetPassword);
    Map body = {
      'token': token,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  }

  Future<void> updateUser(String email, String fullName) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(Endpoint.updateUser);
    Map body = {'email': email, 'fullName': fullName};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(Endpoint.changePassword);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    Map<String, String> body = {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // Password changed successfully
      } else if (response.statusCode == 401) {
        throw Exception('Current password is incorrect.');
      } else {
        throw Exception('Failed to change password: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString('fullName') ?? '';
    String email = prefs.getString('email') ?? '';
    String phoneNumber = prefs.getString('phoneNumber') ?? '';
    String role = prefs.getString('role') ?? 'CUS';

    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role
    };
  }
}





// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:thebags_mobile/apis/endpoint.dart';

// class CustomerService {
//   Future<String> loginWebAccount(String email, String password) async {
//     var headers = {'Content-Type': 'application/json'};
//     var url = Uri.parse(Endpoint.signin);
//     Map body = {'email': email, 'password': password};

//     final response =
//         await http.post(url, headers: headers, body: jsonEncode(body));
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);

//       final prefs = await SharedPreferences.getInstance();
//       prefs.setString('fullName', json['fullName']);
//       prefs.setString('email', json['email']);
//       String role = json['roles'] != null ? json['roles'][0] : 'CUS';
//       prefs.setString('role', role);
//       return role;
//     } else if (response.statusCode == 401) {
//       throw Exception('Invalid email or password');
//     } else if (response.statusCode == 404) {
//       throw Exception('Email not found');
//     } else {
//       throw Exception('Failed to log in');
//     }
//   }
// }
