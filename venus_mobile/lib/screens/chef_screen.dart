import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/cartline_api.dart';
import '../constants/theme.dart';
import '../models/cart_line.dart';
import 'order_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Hàm chuẩn hóa tên bàn để đảm bảo tính nhất quán
String formatTableName(String tableName) {
  return tableName.toLowerCase().contains('table')
      ? tableName
      : 'Table $tableName';
}

class ChefScreen extends StatefulWidget {
  @override
  _ChefScreenState createState() => _ChefScreenState();
}

class _ChefScreenState extends State<ChefScreen> {
  late Future<List<CartLine>> cartLines;
  OrderStatus? selectedStatus;
  String filterTable = '';
  String filterDishName = '';

  @override
  void initState() {
    super.initState();
    refreshCartLines();
  }

  Future<void> refreshCartLines() async {
    List<CartLine> allCartLines = await CartLineApi().fetchCartLines();
    List<CartLine> filteredCartLines = allCartLines.where((cartLine) {
      final matchesStatus =
          selectedStatus == null || cartLine.status == selectedStatus;
      final matchesTable = filterTable.isEmpty ||
          cartLine.tableName.toLowerCase().contains(filterTable.toLowerCase());
      final matchesDishName = filterDishName.isEmpty ||
          cartLine.ingredientName
              .toLowerCase()
              .contains(filterDishName.toLowerCase());
      return matchesStatus && matchesTable && matchesDishName;
    }).toList();

    // Sắp xếp các món ăn theo trạng thái trước, sau đó theo thời gian order mới nhất lên trước
    filteredCartLines.sort((a, b) {
      if (a.status == b.status) {
        return b.orderTime.compareTo(a.orderTime);
      } else {
        return _compareStatus(a.status, b.status);
      }
    });

    setState(() {
      cartLines = Future.value(filteredCartLines);
    });
  }

  void _updateStatus(int cartLineId, OrderStatus newStatus) async {
    bool success = await CartLineApi()
        .updateCartLineStatus(cartLineId, newStatus.toString().split('.').last);
    if (success) {
      Fluttertoast.showToast(
        msg: "Status updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      refreshCartLines();
    } else {
      Fluttertoast.showToast(
        msg: "Failed to update status",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  int _compareStatus(OrderStatus a, OrderStatus b) {
    const statusOrder = {
      OrderStatus.PENDING: 1,
      OrderStatus.PREPARING: 2,
      OrderStatus.READY: 3,
    };
    return statusOrder[a]!.compareTo(statusOrder[b]!);
  }

  void _navigateToOrderDetail(String tableName) async {
    var allLines = await CartLineApi().fetchCartLines(); // Load all lines
    var orderLines = allLines
        .where((line) =>
            formatTableName(line.tableName) == formatTableName(tableName))
        .toList(); // Lấy tất cả các món trong bàn đó

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(
          orderId: orderLines.isNotEmpty ? orderLines.first.orderId : -1,
          tableName:
              formatTableName(tableName), // Chuẩn hóa tên bàn khi truyền đi
          orderLines: orderLines,
          onStatusChanged: (cartLineId, newStatus) async {
            bool success = await CartLineApi().updateCartLineStatus(
                cartLineId, newStatus.toString().split('.').last);
            if (success) {
              setState(() {
                final index = allLines
                    .indexWhere((line) => line.cartLineId == cartLineId);
                if (index != -1) {
                  allLines[index].status = newStatus;
                }
              });
              if (newStatus == OrderStatus.READY) {
                refreshCartLines();
              }
            } else {
              Fluttertoast.showToast(
                msg: "Failed to update status",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
        ),
      ),
    );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Dishes to Prepare'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshCartLines,
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Filter by Table',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  filterTable = value;
                  refreshCartLines();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by Dish Name',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  filterDishName = value;
                  refreshCartLines();
                });
              },
            ),
          ),
          DropdownButton<OrderStatus?>(
            value: selectedStatus,
            hint: Text("Filter by Status"),
            onChanged: (OrderStatus? newValue) {
              setState(() {
                selectedStatus = newValue;
                refreshCartLines();
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshCartLines,
              child: FutureBuilder<List<CartLine>>(
                future: cartLines,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    // Không cần nhóm theo bàn
                    List<CartLine> orderLines = snapshot.data!;

                    return ListView.builder(
                      itemCount: orderLines.length,
                      itemBuilder: (context, index) {
                        CartLine cartLine = orderLines[index];

                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: orderLines.map((cartLine) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                Icons
                                                    .restaurant, // Icon cái bàn ăn
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width:
                                                    4, // Khoảng cách giữa icon và tên bàn
                                              ),
                                              Text(
                                                formatTableName(
                                                    cartLine.tableName),
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
                                                Icons
                                                    .production_quantity_limits,
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
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors
                                                      .black, // Đổi màu chữ thời gian để rõ ràng hơn
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                _getStatusIcon(cartLine.status),
                                                color: _getStatusColor(
                                                    cartLine.status),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Status: ${cartLine.status.toString().split('.').last}',
                                                style: TextStyle(
                                                  color: _getStatusColor(
                                                      cartLine.status),
                                                ),
                                              ),
                                            ],
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
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () => _navigateToOrderDetail(
                                          cartLine.tableName),
                                      child: Text('View Order Details'),
                                    ),
                                    DropdownButton<OrderStatus>(
                                      value: cartLine.status,
                                      onChanged: (OrderStatus? newStatus) {
                                        if (newStatus != null &&
                                            (newStatus == OrderStatus.PENDING ||
                                                newStatus ==
                                                    OrderStatus.PREPARING ||
                                                newStatus ==
                                                    OrderStatus.READY)) {
                                          _updateStatus(
                                              cartLine.cartLineId, newStatus);
                                        }
                                      },
                                      items: [
                                        DropdownMenuItem<OrderStatus>(
                                          value: OrderStatus.PENDING,
                                          child: Row(
                                            children: [
                                              Icon(
                                                  _getStatusIcon(
                                                      OrderStatus.PENDING),
                                                  color: _getStatusColor(
                                                      OrderStatus.PENDING)),
                                              SizedBox(width: 8),
                                              Text("PENDING"),
                                            ],
                                          ),
                                        ),
                                        DropdownMenuItem<OrderStatus>(
                                          value: OrderStatus.PREPARING,
                                          child: Row(
                                            children: [
                                              Icon(
                                                  _getStatusIcon(
                                                      OrderStatus.PREPARING),
                                                  color: _getStatusColor(
                                                      OrderStatus.PREPARING)),
                                              SizedBox(width: 8),
                                              Text("PREPARING"),
                                            ],
                                          ),
                                        ),
                                        DropdownMenuItem<OrderStatus>(
                                          value: OrderStatus.READY,
                                          child: Row(
                                            children: [
                                              Icon(
                                                  _getStatusIcon(
                                                      OrderStatus.READY),
                                                  color: _getStatusColor(
                                                      OrderStatus.READY)),
                                              SizedBox(width: 8),
                                              Text("READY"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: Text('No data available. Pull to refresh.'));
                  }
                },
              ),
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
            child: Text('Chef Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pop(context);
              context.go('/signin');
            },
          ),
        ],
      ),
    );
  }
}
