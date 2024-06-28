enum IngredientStatus { Available, OutofStock, Expired }

class Ingredient {
  final int id;
  final String ingredientName;
  final double weight;
  final String description;
  final String ingredientCode;
  final String categoryName;
  final int categoryId;
  final double quantityInStock;
  final double price;
  final String photo;
  IngredientStatus status;

  Ingredient({
    required this.id,
    required this.ingredientName,
    required this.weight,
    required this.description,
    required this.ingredientCode,
    required this.categoryName,
    required this.categoryId,
    required this.quantityInStock,
    required this.price,
    required this.photo,
    required this.status,
  });
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'] ?? 0,
      ingredientName: json['ingredientName'] ?? '',
      weight: json['weight'] != null
          ? double.parse(json['weight'].toString())
          : 0.0,
      description: json['description'] ?? '',
      ingredientCode: json['ingredientCode'] ?? '',
      categoryName: json['categoryName'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      quantityInStock: json['quantityInStock'] != null
          ? double.parse(json['quantityInStock'].toString())
          : 0.0,
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
      photo: json['photo'] ?? '',
      status: IngredientStatus.values.firstWhere(
        (e) => e.toString() == 'IngredientStatus.${json['status']}',
        orElse: () => IngredientStatus.Available,
      ),
    );
  }
}
