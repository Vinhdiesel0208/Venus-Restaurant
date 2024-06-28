import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart_line.dart';
import '../apis/cartline_api.dart';

// Hàm chuẩn hóa tên bàn để đảm bảo tính nhất quán
String formatTableName(String tableName) {
  return tableName.toLowerCase().contains('table')
      ? tableName
      : 'Table $tableName';
}

class OrderDetail_StaffScreen extends StatefulWidget {
  final String tableName;

  OrderDetail_StaffScreen({
    required this.tableName,
  });

  @override
  _OrderDetail_StaffScreenState createState() =>
      _OrderDetail_StaffScreenState();
}

class _OrderDetail_StaffScreenState extends State<OrderDetail_StaffScreen> {
  late Future<List<CartLine>> orderLines;

  @override
  void initState() {
    super.initState();
    orderLines = _fetchOrderLines();
  }

  // Lấy danh sách các món ăn dựa trên tên bàn đã chuẩn hóa
  Future<List<CartLine>> _fetchOrderLines() async {
    var allLines = await CartLineApi().fetchCartLines();
    String formattedTableName =
        formatTableName(widget.tableName); // Chuẩn hóa tên bàn
    return allLines
        .where((line) => formatTableName(line.tableName) == formattedTableName)
        .toList();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details - ${widget.tableName}'),
      ),
      body: FutureBuilder<List<CartLine>>(
        future: orderLines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No order details available.'));
          }

          var orderLines = snapshot.data!;
          orderLines.sort((a, b) => a.orderTime.compareTo(b
              .orderTime)); // Sắp xếp theo thứ tự thời gian từ cũ nhất đến mới nhất

          return ListView.builder(
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
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.restaurant, // Icon cái bàn ăn
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width:
                                          4, // Khoảng cách giữa icon và tên bàn
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
                                SizedBox(height: 8),
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
                                SizedBox(height: 8),
                                Text(
                                  'Status: ${cartLine.status.toString().split('.').last}',
                                  style: TextStyle(
                                    color: _getStatusColor(cartLine.status),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl: cartLine.ingredientPhoto,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
