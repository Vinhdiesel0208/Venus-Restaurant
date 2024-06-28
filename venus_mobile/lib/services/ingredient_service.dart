import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Ingredient.dart';
import '../apis/endpoint.dart';

class IngredientService {
  Future<List<Ingredient>> getAllIngredients() async {
    try {
      final response = await http.get(Uri.parse(Endpoint.getIngredients));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Ingredient.fromJson(data)).toList();
      } else {
        print('Failed to fetch Ingredients: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error in IngredientApi getAllIngredients: $e');
      throw Exception('Failed to load Ingredients');
    }
  }

  Future<Ingredient?> getById(int id) async {
    try {
      final response =
          await http.get(Uri.parse('${Endpoint.getIngredientById}/$id'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return Ingredient.fromJson(jsonData);
      } else {
        print('Failed to fetch Ingredient with ID $id: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error in IngredientService getById: $e');
      throw Exception('Failed to load Ingredient');
    }
  }
}
