import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thebags_mobile/apis/cartline_api.dart';
import 'package:thebags_mobile/constants/theme.dart';
import 'package:thebags_mobile/models/cart_line.dart';
import 'package:thebags_mobile/widgets/drawer_title.dart';

class OrderHistoryScreen extends StatefulWidget {
  final int tableId;

  OrderHistoryScreen({required this.tableId});

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final CartLineApi _cartLineApi = CartLineApi();
  List<CartLine> _orderLines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrderLinesForTable();
  }

  void _fetchOrderLinesForTable() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<CartLine> orderLines =
          await _cartLineApi.fetchCartLinesForTable(widget.tableId);
      setState(() {
        _orderLines = _consolidateCartLines(orderLines);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching order lines: $e');
    }
  }

  List<CartLine> _consolidateCartLines(List<CartLine> orderLines) {
    Map<String, CartLine> consolidatedMap = {};

    for (var orderLine in orderLines) {
      if (consolidatedMap.containsKey(orderLine.ingredientName)) {
        var existingOrderLine = consolidatedMap[orderLine.ingredientName]!;
        consolidatedMap[orderLine.ingredientName] = CartLine(
          cartLineId: existingOrderLine.cartLineId,
          orderId: existingOrderLine.orderId,
          tableId: existingOrderLine.tableId,
          tableName: existingOrderLine.tableName,
          ingredientId: existingOrderLine.ingredientId,
          ingredientName: existingOrderLine.ingredientName,
          quantity: existingOrderLine.quantity + orderLine.quantity,
          price: existingOrderLine.price,
          status: existingOrderLine.status,
          halfPortion: existingOrderLine.halfPortion,
          orderTime: existingOrderLine.orderTime,
          ingredientPhoto: existingOrderLine.ingredientPhoto,
        );
      } else {
        consolidatedMap[orderLine.ingredientName] = orderLine;
      }
    }

    return consolidatedMap.values.toList();
  }

  void _showDeleteConfirmation(CartLine orderLine) {
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
                _deleteOrderLine(orderLine);
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

  void _updateQuantity(CartLine cartLine, bool isIncrement) async {
    try {
      final newQuantity =
          isIncrement ? cartLine.quantity + 1 : cartLine.quantity - 1;

      if (newQuantity > 0) {
        await _cartLineApi.updateCartLineQuantity(
            cartLine.cartLineId, newQuantity);

        setState(() {
          final index = _orderLines
              .indexWhere((cl) => cl.cartLineId == cartLine.cartLineId);
          if (index != -1) {
            _orderLines[index] =
                _orderLines[index].copyWith(quantity: newQuantity);
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

  void _deleteOrderLine(CartLine orderLine) async {
    try {
      bool success = await _cartLineApi.deleteCartLine(orderLine.cartLineId);
      if (success) {
        setState(() {
          _orderLines
              .removeWhere((cl) => cl.cartLineId == orderLine.cartLineId);
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

  void _navigateToMenu() {
    context.go('/ingredients/${widget.tableId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History for Table ${widget.tableId}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/tables');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchOrderLinesForTable,
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
                _buildOrderHeader(),
                Expanded(
                  child: _orderLines.isEmpty
                      ? Center(child: Text('No items in the order history'))
                      : ListView.builder(
                          itemCount: _orderLines.length,
                          itemBuilder: (context, index) {
                            final orderLine = _orderLines[index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(orderLine.ingredientPhoto),
                                onBackgroundImageError: (_, __) =>
                                    Icon(Icons.broken_image),
                              ),
                              title: Text(
                                '${index + 1}. ${orderLine.ingredientName}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () =>
                                        _updateQuantity(orderLine, false),
                                  ),
                                  Text('${orderLine.quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () =>
                                        _updateQuantity(orderLine, true),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.red, size: 20),
                                    onPressed: () =>
                                        _showDeleteConfirmation(orderLine),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${(orderLine.price * orderLine.quantity).toStringAsFixed(2)}',
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
                  child: ElevatedButton(
                    onPressed: _navigateToMenu,
                    child: Text('Continue Order'),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOrderHeader() {
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
