import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cart_line.dart';
import '../widgets/status_dropdown_button.dart';

class ChefItem extends StatelessWidget {
  final CartLine cartLine;
  final Function(OrderStatus) onStatusChanged;

  ChefItem({
    Key? key,
    required this.cartLine,
    required this.onStatusChanged,
  }) : super(key: key);

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.PENDING:
        return Colors.red; // Đỏ cho đang chờ xử lý
      case OrderStatus.PREPARING:
        return Color.fromARGB(255, 255, 165, 0); // Vàng cam cho đang chuẩn bị
      case OrderStatus.READY:
        return Colors.green; // Xanh lá cho sẵn sàng
      case OrderStatus.SERVING:
        return Colors.blue; // Xanh dương cho đang phục vụ
      case OrderStatus.COMPLETED:
        return Colors.purple; // Tím cho hoàn thành
      default:
        return Colors.grey; // Màu xám cho các trạng thái không xác định
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartLine.cartLineId.toString()),
      background: Container(color: Colors.red),
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
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
                        SizedBox(height: 8.0),
                        Text('Table: ${cartLine.tableName}'),
                        SizedBox(height: 8.0),
                        Text('Quantity: ${cartLine.quantity.toString()}'),
                        SizedBox(height: 8.0),
                        Text('Price: \$${cartLine.price.toString()}'),
                        SizedBox(height: 8.0),
                        Text(
                            'Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(cartLine.orderTime)}'),
                        SizedBox(height: 8.0),
                        Text(
                          'Status: ${cartLine.status.toString().split('.').last}',
                          style: TextStyle(
                              color: _getStatusColor(cartLine.status)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Handle Details button press
                    },
                    child: Text('Details'),
                  ),
                  StatusDropdownButton(
                    currentStatus: cartLine.status,
                    onStatusChanged: (newStatus) {
                      onStatusChanged(newStatus);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
