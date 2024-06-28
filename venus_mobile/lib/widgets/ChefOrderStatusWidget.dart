import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart_line.dart';
import '../apis/cartline_api.dart';

class ChefOrderStatusWidget extends StatefulWidget {
  @override
  _ChefOrderStatusWidgetState createState() => _ChefOrderStatusWidgetState();
}

class _ChefOrderStatusWidgetState extends State<ChefOrderStatusWidget> {
  late Future<List<CartLine>> cartLines;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.red;
      case 'PREPARING':
        return Colors.amber[800]!;
      case 'READY':
        return Colors.green;
      case 'SERVING':
        return Colors.blue;
      case 'COMPLETE':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    cartLines = CartLineApi().fetchCartLines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Order Status'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                cartLines = CartLineApi().fetchCartLines();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<CartLine>>(
        future: cartLines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var cartLine = snapshot.data![index];
                return _buildOrderItem(cartLine);
              },
            );
          } else {
            return Center(child: Text('No orders found.'));
          }
        },
      ),
    );
  }

  Widget _buildOrderItem(CartLine cartLine) {
    Color statusColor =
        _getStatusColor(cartLine.status.toString().split('.').last);

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
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 8),
                      Text('Table: ${cartLine.tableName}'),
                      SizedBox(height: 8),
                      Text('Quantity: ${cartLine.quantity.toString()}'),
                      SizedBox(height: 8),
                      Text('Price: \$${cartLine.price.toString()}'),
                      SizedBox(height: 8),
                      Text(
                          'Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(cartLine.orderTime)}'),
                      SizedBox(height: 8),
                      Text(
                          'Status: ${cartLine.status.toString().split('.').last}',
                          style: TextStyle(color: statusColor)),
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
          ],
        ),
      ),
    );
  }
}
