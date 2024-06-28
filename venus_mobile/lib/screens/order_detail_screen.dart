import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../models/cart_line.dart';
import 'package:fluttertoast/fluttertoast.dart';

String formatTableName(String tableName) {
  return tableName.toLowerCase().contains('table')
      ? tableName
      : 'Table $tableName';
}

class OrderDetailScreen extends StatefulWidget {
  final int orderId;
  final String tableName;
  final List<CartLine> orderLines;
  final Function(int, OrderStatus) onStatusChanged;

  OrderDetailScreen({
    required this.orderId,
    required this.tableName,
    required this.orderLines,
    required this.onStatusChanged,
  });

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late List<CartLine> orderLines;

  @override
  void initState() {
    super.initState();
    orderLines = widget.orderLines;
  }

  void _updateStatus(
      BuildContext context, int cartLineId, OrderStatus newStatus) {
    widget.onStatusChanged(cartLineId, newStatus);
    Fluttertoast.showToast(
      msg: "Status updated to ${newStatus.toString().split('.').last}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    setState(() {
      int index =
          orderLines.indexWhere((line) => line.cartLineId == cartLineId);
      if (index != -1) {
        orderLines[index].status = newStatus;
      }
    });
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.PENDING:
        return Icons.access_time;
      case OrderStatus.PREPARING:
        return Icons.kitchen;
      case OrderStatus.READY:
        return Icons.check_circle;
      case OrderStatus.SERVING:
        return Icons.room_service;
      case OrderStatus.COMPLETED:
        return Icons.done;
      default:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.PENDING:
        return Colors.red;
      case OrderStatus.PREPARING:
        return Colors.orange;
      case OrderStatus.READY:
        return Colors.green;
      case OrderStatus.SERVING:
        return Colors.blue;
      case OrderStatus.COMPLETED:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sắp xếp orderLines theo thứ tự ưu tiên
    orderLines.sort((a, b) => a.status.index.compareTo(b.status.index));

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details - ${widget.tableName}'),
      ),
      body: ListView.builder(
        itemCount: orderLines.length,
        itemBuilder: (context, index) {
          var cartLine = orderLines[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dish: ${cartLine.ingredientName}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.restaurant, // Icon cái bàn ăn
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 4, // Khoảng cách giữa icon và tên bàn
                                ),
                                Text(
                                  formatTableName(cartLine.tableName),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.production_quantity_limits,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Quantity: ${cartLine.quantity}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors
                                      .red, // Đổi màu biểu tượng giá tiền để rõ ràng hơn
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Price: \$${cartLine.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors
                                        .black, // Đổi màu chữ giá tiền để rõ ràng hơn
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons
                                      .access_time_filled, // Đổi sang icon khác để không giống với pending
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Time: ${DateFormat('dd/MM/yyyy - kk:mm').format(cartLine.orderTime)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight
                                        .normal, // Màu thời gian đậm hơn
                                    color: Colors
                                        .black, // Đổi màu chữ thời gian để rõ ràng hơn
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Status: ${cartLine.status.toString().split('.').last}',
                              style: TextStyle(
                                color: _getStatusColor(cartLine.status),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.network(
                        cartLine.ingredientPhoto,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      DropdownButton<OrderStatus>(
                        value: cartLine.status,
                        onChanged: (OrderStatus? newStatus) {
                          if (newStatus != null &&
                              (newStatus == OrderStatus.PENDING ||
                                  newStatus == OrderStatus.PREPARING ||
                                  newStatus == OrderStatus.READY)) {
                            _updateStatus(
                                context, cartLine.cartLineId, newStatus);
                          }
                        },
                        items: [
                          DropdownMenuItem<OrderStatus>(
                            value: OrderStatus.PENDING,
                            child: Row(
                              children: [
                                Icon(_getStatusIcon(OrderStatus.PENDING),
                                    color:
                                        _getStatusColor(OrderStatus.PENDING)),
                                SizedBox(width: 8),
                                Text("PENDING"),
                              ],
                            ),
                          ),
                          DropdownMenuItem<OrderStatus>(
                            value: OrderStatus.PREPARING,
                            child: Row(
                              children: [
                                Icon(_getStatusIcon(OrderStatus.PREPARING),
                                    color:
                                        _getStatusColor(OrderStatus.PREPARING)),
                                SizedBox(width: 8),
                                Text("PREPARING"),
                              ],
                            ),
                          ),
                          DropdownMenuItem<OrderStatus>(
                            value: OrderStatus.READY,
                            child: Row(
                              children: [
                                Icon(_getStatusIcon(OrderStatus.READY),
                                    color: _getStatusColor(OrderStatus.READY)),
                                SizedBox(width: 8),
                                Text("READY"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
