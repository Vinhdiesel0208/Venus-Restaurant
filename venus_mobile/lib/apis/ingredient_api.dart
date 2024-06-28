import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ingredient.dart';
import 'endpoint.dart';

class IngredientApi {
  Future<List<Ingredient>> getIngredients() async {
    try {
      final response = await http.get(Uri.parse(Endpoint.getIngredients));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Ingredient.fromJson(data)).toList();
      } else {
        print('Failed to fetch Ingredient: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error in IngredientApi getIngredients: $e');
      throw Exception('Failed to load posts');
    }
  }
}
