import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:thebags_mobile/models/ingredient.dart';
import 'endpoint.dart';
import '../helpers/auth_helper.dart';
import '../models/cart_line.dart';

class CartLineApi {
  Future<List<CartLine>> fetchCartLines() async {
    try {
      final token = await AuthHelper.getToken();
      final response = await http.get(
        Uri.parse(Endpoint.chefDishes),
        headers: {"Authorization": "Bearer $token"},
      );
      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<CartLine> cartLines =
            body.map((dynamic item) => CartLine.fromJson(item)).toList();
        return cartLines;
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        throw Exception('Failed to load cart lines');
      }
    } catch (e) {
      print("Error fetching cart lines: $e");
      throw Exception('Error fetching cart lines: $e');
    }
  }

  Future<List<CartLine>> fetchCartLinesForTable(int tableId) async {
    final token = await AuthHelper.getToken();
    final response = await http.get(
      Uri.parse('${Endpoint.staffCartLines}/$tableId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<CartLine> cartLines =
          body.map((dynamic item) => CartLine.fromJson(item)).toList();
      return cartLines;
    } else {
      throw Exception('Failed to load cart lines');
    }
  }

  Future<bool> updateCartLineStatus(int cartLineId, String status) async {
    final token = await AuthHelper.getToken();
    final response = await http.post(
      Uri.parse(Endpoint.updateCartLineStatus),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        'cartLineId': cartLineId,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      print("Status updated successfully");
      return true;
    } else {
      print("Failed to update status: ${response.body}");
      return false;
    }
  }

  Future<bool> deleteCartLine(int cartLineId) async {
    final token = await AuthHelper.getToken();
    final response = await http.delete(
      Uri.parse('${Endpoint.deleteCartLine}/$cartLineId'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      print("Cart line deleted successfully");
      return true;
    } else {
      print("Failed to delete cart line: ${response.body}");
      return false;
    }
  }

  Future<bool> checkoutTable(int tableId) async {
    final token = await AuthHelper.getToken();

    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.post(
      Uri.parse('${Endpoint.baseUrl}/chef/checkout/$tableId'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to checkout table');
    }
  }

  Future<void> addToCart(int tableId, int ingredientId, double quantity,
      double price, bool halfPortion, String tableName) async {
    final token = await AuthHelper.getToken();

    if (token == null) {
      throw Exception('Token is null');
    }

    print('Token used for request: $token');

    final response = await http.post(
      Uri.parse(Endpoint.addToCart),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'restaurantTableId': tableId,
        'ingredientId': ingredientId,
        'quantity': quantity,
        'price': price,
        'halfPortion': halfPortion,
        'tableName': tableName,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      if (response.body.contains('Not enough stock available')) {
        Fluttertoast.showToast(
          msg: 'Not enough stock available',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      throw Exception('Failed to add to cart');
    }
  }

  Future<Ingredient> fetchIngredient(int ingredientId) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse(
          '${Endpoint.getIngredientById.replaceAll("{id}", ingredientId.toString())}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Ingredient.fromJson(body);
    } else {
      throw Exception('Failed to load ingredient');
    }
  }

  Future<void> updateCartLineQuantity(int cartLineId, double quantity) async {
    final token = await AuthHelper.getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final uri = Uri.parse('${Endpoint.updateCartLineQuantity}/$cartLineId')
        .replace(queryParameters: {'quantity': quantity.toString()});

    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      if (response.body.contains('Not enough stock available')) {
        throw Exception('Not enough stock available');
      }
      throw Exception(
          'Failed to update quantity. Status code: ${response.statusCode}, body: ${response.body}');
    } else {
      print('Quantity updated successfully');
    }
  }

  void updateQuantity(int cartLineId, double newQuantity) async {
    try {
      await CartLineApi().updateCartLineQuantity(cartLineId, newQuantity);
      print('Quantity updated successfully');
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }
}
