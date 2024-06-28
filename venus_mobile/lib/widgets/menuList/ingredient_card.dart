import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Thêm import này
import 'package:thebags_mobile/models/ingredient.dart';

class IngredientCard extends StatefulWidget {
  final Ingredient ingredient;
  final Function(Ingredient, double) addToCart;

  const IngredientCard({
    required this.ingredient,
    required this.addToCart,
  });

  @override
  _IngredientCardState createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      if (_quantity < widget.ingredient.quantityInStock) {
        _quantity++;
      } else {
        Fluttertoast.showToast(
          msg:
              '${widget.ingredient.ingredientName} is temporarily out of stock.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                widget.ingredient.photo,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.ingredient.ingredientName,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Price: \$${widget.ingredient.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    widget.ingredient.description,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: Icon(Icons.remove, size: 20.0),
                    ),
                    Text(
                      '$_quantity',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: Icon(Icons.add, size: 20.0),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (widget.ingredient.quantityInStock == 0) {
                      Fluttertoast.showToast(
                        msg:
                            '${widget.ingredient.ingredientName} is temporarily out of stock.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      widget.addToCart(widget.ingredient, _quantity.toDouble());
                    }
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
