import 'package:flutter/material.dart';
import 'package:thebags_mobile/models/ingredient.dart';
import 'package:thebags_mobile/widgets/menuList/ingredient_card.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final List<Ingredient> categoryIngredients;
  final Function(Ingredient, double) addToCart;

  const CategoryCard({
    required this.categoryName,
    required this.categoryIngredients,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Category: $categoryName',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: categoryIngredients.length,
          itemBuilder: (context, index) {
            Ingredient ingredient = categoryIngredients[index];
            return IngredientCard(
              ingredient: ingredient,
              addToCart: addToCart,
            );
          },
        ),
      ],
    );
  }
}
