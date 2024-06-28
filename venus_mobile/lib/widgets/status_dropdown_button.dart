import 'package:flutter/material.dart';
import '../models/cart_line.dart';

class StatusDropdownButton extends StatelessWidget {
  final OrderStatus currentStatus;
  final Function(OrderStatus) onStatusChanged;

  StatusDropdownButton({
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<OrderStatus>(
      value: currentStatus,
      onChanged: (OrderStatus? newStatus) {
        if (newStatus != null &&
            (newStatus == OrderStatus.PENDING ||
                newStatus == OrderStatus.PREPARING ||
                newStatus == OrderStatus.READY)) {
          onStatusChanged(newStatus);
        }
      },
      items: OrderStatus.values
          .where((status) =>
              status == OrderStatus.PENDING ||
              status == OrderStatus.PREPARING ||
              status == OrderStatus.READY)
          .map((OrderStatus status) {
        return DropdownMenuItem<OrderStatus>(
          value: status,
          child: Text(status.toString().split('.').last),
        );
      }).toList(),
    );
  }
}
