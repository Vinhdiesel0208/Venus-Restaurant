
import 'package:flutter/material.dart';

import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/models/ingredient.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  final VoidCallback onPressed;

  const IngredientItem({
    Key? key,
    required this.ingredient,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(ingredient.photo),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ingredient.ingredientName,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Price: \$${ingredient.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: ArgonColors.success,
            ),
          ),
        ],
      ),
      subtitle: Text(
        ingredient.description,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 8.0),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Order',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: ArgonColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}