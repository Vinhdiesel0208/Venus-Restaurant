import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart_line.dart';
import '../apis/cartline_api.dart';
import 'order_detail_staff_screen.dart';

// Hàm chuẩn hóa tên bàn để đảm bảo tính nhất quán
String formatTableName(String tableName) {
  return tableName.toLowerCase().contains('table')
      ? tableName
      : 'Table $tableName';
}

class StaffOrderStatusScreen extends StatefulWidget {
  @override
  _StaffOrderStatusScreenState createState() => _StaffOrderStatusScreenState();
}

class _StaffOrderStatusScreenState extends State<StaffOrderStatusScreen> {
  late Future<List<CartLine>> cartLines;
  String filterTable = '';
  OrderStatus? filterStatus;

  @override
  void initState() {
    super.initState();
    _loadCartLines();
  }

  void _loadCartLines() {
    setState(() {
      cartLines = CartLineApi().fetchCartLines().then((lines) {
        lines.sort((a, b) => a.orderTime.compareTo(b.orderTime));
        return lines;
      });
    });
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.PENDING:
        return Colors.red;
      case OrderStatus.PREPARING:
        return Colors.amber[800]!;
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

  // Chuẩn hóa tên bàn khi điều hướng đến OrderDetail_StaffScreen
  void _navigateToOrderDetail(String tableName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetail_StaffScreen(
          tableName: formatTableName(tableName),
        ),
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      filterTable = '';
      filterStatus = null;
      _loadCartLines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Order Status'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadCartLines,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Filter by Table',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filterTable = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearFilters,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<OrderStatus?>(
              isExpanded: true,
              value: filterStatus,
              hint: Text("Filter by Status"),
              onChanged: (OrderStatus? newValue) {
                setState(() {
                  filterStatus = newValue;
                });
              },
              items: [
                DropdownMenuItem<OrderStatus?>(
                  value: null,
                  child: Text("All Status"),
                ),
                DropdownMenuItem<OrderStatus?>(
                  value: OrderStatus.PENDING,
                  child: Row(
                    children: [
                      Icon(_getStatusIcon(OrderStatus.PENDING),
                          color: _getStatusColor(OrderStatus.PENDING)),
                      SizedBox(width: 8),
                      Text("PENDING"),
                    ],
                  ),
                ),
                DropdownMenuItem<OrderStatus?>(
                  value: OrderStatus.PREPARING,
                  child: Row(
                    children: [
                      Icon(_getStatusIcon(OrderStatus.PREPARING),
                          color: _getStatusColor(OrderStatus.PREPARING)),
                      SizedBox(width: 8),
                      Text("PREPARING"),
                    ],
                  ),
                ),
                DropdownMenuItem<OrderStatus?>(
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
          ),
          Expanded(
            child: FutureBuilder<List<CartLine>>(
              future: cartLines,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<CartLine> filteredLines = snapshot.data!.where((line) {
                    bool matchesStatus =
                        filterStatus == null || line.status == filterStatus;
                    bool matchesTable = filterTable.isEmpty ||
                        line.tableName
                            .toLowerCase()
                            .contains(filterTable.toLowerCase());
                    return matchesStatus &&
                        matchesTable &&
                        line.status != OrderStatus.COMPLETED;
                  }).toList();

                  if (filteredLines.isEmpty) {
                    return Center(child: Text('No data available.'));
                  }

                  return ListView.builder(
                    itemCount: filteredLines.length,
                    itemBuilder: (context, index) {
                      var cartLine = filteredLines[index];
                      return _buildOrderItem(cartLine);
                    },
                  );
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartLine cartLine) {
    Color statusColor = _getStatusColor(cartLine.status);
    IconData statusIcon = _getStatusIcon(cartLine.status);

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
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
                      Text('Dish: ${cartLine.ingredientName}',
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(height: 8),
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
                              fontWeight:
                                  FontWeight.normal, // Màu thời gian đậm hơn
                              color: Colors
                                  .black, // Đổi màu chữ thời gian để rõ ràng hơn
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(statusIcon, color: statusColor),
                          SizedBox(width: 4),
                          Text(
                            'Status: ${cartLine.status.toString().split('.').last}',
                            style: TextStyle(color: statusColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: cartLine.ingredientPhoto,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _navigateToOrderDetail(cartLine.tableName);
                },
                child: Text('View Order Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
