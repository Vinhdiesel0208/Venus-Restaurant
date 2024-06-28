import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/apis/cartline_api.dart';
import 'package:thebags_mobile/models/cart_line.dart';
import 'package:thebags_mobile/widgets/drawer_title.dart';

import '../constants/theme.dart';

class CartScreen extends StatefulWidget {
  final int tableId;

  CartScreen({required this.tableId});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartLineApi _cartLineApi = CartLineApi();
  List<CartLine> _cartLines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCartLinesForTable();
  }

  void _fetchCartLinesForTable() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<CartLine> cartLines =
          await _cartLineApi.fetchCartLinesForTable(widget.tableId);
      setState(() {
        _cartLines = _consolidateCartLines(cartLines);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching cart lines: $e');
    }
  }

  List<CartLine> _consolidateCartLines(List<CartLine> cartLines) {
    Map<String, CartLine> consolidatedMap = {};

    for (var cartLine in cartLines) {
      if (consolidatedMap.containsKey(cartLine.ingredientName)) {
        var existingCartLine = consolidatedMap[cartLine.ingredientName]!;
        consolidatedMap[cartLine.ingredientName] = CartLine(
          cartLineId: existingCartLine.cartLineId,
          orderId: existingCartLine.orderId,
          tableId: existingCartLine.tableId,
          tableName: existingCartLine.tableName,
          ingredientId: existingCartLine.ingredientId,
          ingredientName: existingCartLine.ingredientName,
          quantity: existingCartLine.quantity + cartLine.quantity,
          price: existingCartLine.price,
          status: existingCartLine.status,
          halfPortion: existingCartLine.halfPortion,
          orderTime: existingCartLine.orderTime,
          ingredientPhoto: existingCartLine.ingredientPhoto,
        );
      } else {
        consolidatedMap[cartLine.ingredientName] = cartLine;
      }
    }

    return consolidatedMap.values.toList();
  }

  void _updateQuantity(CartLine cartLine, bool isIncrement) async {
    try {
      final newQuantity =
          isIncrement ? cartLine.quantity + 1 : cartLine.quantity - 1;

      if (newQuantity > 0) {
        await _cartLineApi.updateCartLineQuantity(
            cartLine.cartLineId, newQuantity);

        setState(() {
          final index = _cartLines
              .indexWhere((cl) => cl.cartLineId == cartLine.cartLineId);
          if (index != -1) {
            _cartLines[index] =
                _cartLines[index].copyWith(quantity: newQuantity);
          }
        });
      }
    } catch (e) {
      if (e.toString().contains("Not enough stock available")) {
        Fluttertoast.showToast(
          msg: 'Not enough stock available',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update quantity: $e'),
        ));
      }
    }
  }

  void _showDeleteConfirmation(CartLine cartLine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteCartLine(cartLine);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckoutConfirmation(double total) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Checkout'),
          content: Text('Are you sure you want to checkout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToPayment(total);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPayment(double total) {
    context.go('/payment/${widget.tableId}', extra: total);
  }

  void _deleteCartLine(CartLine cartLine) async {
    try {
      bool success = await _cartLineApi.deleteCartLine(cartLine.cartLineId);
      if (success) {
        setState(() {
          _cartLines.removeWhere((cl) => cl.cartLineId == cartLine.cartLineId);
        });
        Fluttertoast.showToast(
          msg: 'Deleted successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to delete item',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error deleting item: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double subtotal =
        _cartLines.fold(0, (sum, item) => sum + item.price * item.quantity);
    double tax = subtotal * 0.10;
    double total = subtotal + tax;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart for Table ${widget.tableId}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/ingredients/${widget.tableId}');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchCartLinesForTable,
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildCartHeader(),
                Expanded(
                  child: _cartLines.isEmpty
                      ? Center(child: Text('No items in the cart'))
                      : ListView.builder(
                          itemCount: _cartLines.length,
                          itemBuilder: (context, index) {
                            final cartLine = _cartLines[index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(cartLine.ingredientPhoto),
                                onBackgroundImageError: (_, __) =>
                                    Icon(Icons.broken_image),
                              ),
                              title: Text(
                                '${index + 1}. ${cartLine.ingredientName}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () =>
                                        _updateQuantity(cartLine, false),
                                  ),
                                  Text('${cartLine.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () =>
                                        _updateQuantity(cartLine, true),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.red, size: 20),
                                    onPressed: () =>
                                        _showDeleteConfirmation(cartLine),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${(cartLine.price * cartLine.quantity).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Divider(),
                      _buildSummaryRow('Subtotal', subtotal),
                      _buildSummaryRow('Tax (10%)', tax),
                      _buildSummaryRow('Total', total, isTotal: true),
                      ElevatedButton(
                        onPressed: () => _showCheckoutConfirmation(total),
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildCartHeader() {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dishes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            'Quantity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            'Price',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          DrawerTitle(
              icon: Icons.list_alt,
              onTap: () {
                context.push('/staff-order-status');
              },
              iconColor: ArgonColors.muted,
              title: 'Order Status',
              isSelected: false),
          DrawerTitle(
              icon: Icons.table_chart,
              onTap: () {
                context.push('/tables');
              },
              iconColor: ArgonColors.primary,
              title: 'Tables',
              isSelected: false),
          ListTile(
            leading: Icon(Icons.logout, color: ArgonColors.muted),
            title: Text('Logout', style: TextStyle(color: ArgonColors.initial)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              context.go('/signin');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
