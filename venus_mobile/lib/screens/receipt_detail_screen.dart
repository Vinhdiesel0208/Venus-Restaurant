import 'package:flutter/material.dart';
import '../models/cart_line.dart';
import '../apis/cartline_api.dart';
import '../models/customer_vinh.dart';

class ReceiptDetailScreen extends StatefulWidget {
  final int tableId;
  final Customer? customer;
  final double discountAmount;
  final double finalAmount;

  ReceiptDetailScreen({
    required this.tableId,
    this.customer,
    this.discountAmount = 0.0,
    this.finalAmount = 0.0,
  });

  @override
  _ReceiptDetailScreenState createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
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

  @override
  Widget build(BuildContext context) {
    double subtotal =
        _cartLines.fold(0, (sum, item) => sum + item.price * item.quantity);
    double tax = subtotal * 0.10;
    double total = subtotal + tax - widget.discountAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Details for Table ${widget.tableId}'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.customer != null) ...[
                    Text('Customer: ${widget.customer!.fullName}'),
                    Text('Points: ${widget.customer!.points}'),
                  ],
                  Text(
                    'Dishes',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cartLines.length,
                      itemBuilder: (context, index) {
                        final cartLine = _cartLines[index];
                        return ListTile(
                          leading: Text('${index + 1}.'),
                          title: Text(cartLine.ingredientName),
                          subtitle: Text('Quantity: ${cartLine.quantity}'),
                          trailing: Text(
                            '\$${(cartLine.price * cartLine.quantity).toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  _buildSummaryRow('Subtotal', subtotal),
                  _buildSummaryRow('Tax (10%)', tax),
                  _buildSummaryRow('Discount', widget.discountAmount),
                  _buildSummaryRow('Total', total, isTotal: true),
                ],
              ),
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
}
