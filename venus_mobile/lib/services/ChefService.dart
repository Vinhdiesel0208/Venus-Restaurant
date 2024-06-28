import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_line.dart'; // Đảm bảo đường dẫn này đúng với vị trí file CartLine của bạn

class ChefService {
  Future<List<CartLine>> fetchCartLines() async {
    final response =
        await http.get(Uri.parse('http://localhost:8082/apis/v1/chef/dishes'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<CartLine> cartLines =
          body.map((dynamic item) => CartLine.fromJson(item)).toList();
      return cartLines;
    } else {
      throw Exception('Failed to load cart lines');
    }
  }

  Future<void> updateCartLineStatus(int cartLineId, OrderStatus status) async {
    final response = await http.post(
      Uri.parse('http://localhost:8082/apis/v1/chef/updateStatus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'cartLineId': cartLineId,
        'status': status.toString().split('.').last,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart line status');
    }
  }
}
