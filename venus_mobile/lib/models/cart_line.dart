enum OrderStatus { PENDING, PREPARING, READY, SERVING, COMPLETED }

class CartLine {
  final int cartLineId;
  final int orderId;
  final String tableName;
  final int tableId;
  final int ingredientId;
  final String ingredientName;
  final double quantity;
  final double price;
  OrderStatus status;
  final bool halfPortion;
  final DateTime orderTime;
  final String ingredientPhoto;

  CartLine({
    required this.cartLineId,
    required this.orderId,
    required this.tableName,
    required this.tableId,
    required this.ingredientId,
    required this.ingredientName,
    required this.quantity,
    required this.price,
    required this.status,
    required this.halfPortion,
    required this.orderTime,
    required this.ingredientPhoto,
  });

  factory CartLine.fromJson(Map<String, dynamic> json) {
    print("Parsing JSON: $json");
    return CartLine(
      cartLineId: json['cartLineId'] ?? 0,
      orderId: json['orderId'] ?? 0,
      tableName: json['tableName'] ?? '',
      tableId: json['tableId'] ?? 0,
      ingredientId: json['ingredientId'] ?? 0,
      ingredientName: json['ingredientName'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
        orElse: () => OrderStatus.PENDING,
      ),
      halfPortion: json['halfPortion'] ?? false,
      orderTime:
          DateTime.parse(json['orderTime'] ?? DateTime.now().toIso8601String()),
      ingredientPhoto: json['ingredientPhoto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartLineId': this.cartLineId,
      'orderId': this.orderId,
      'tableName': this.tableName,
      'tableId': this.tableId,
      'restaurantTableId': this.tableId,
      'ingredientId': this.ingredientId,
      'ingredientName': this.ingredientName,
      'quantity': this.quantity,
      'price': this.price,
      'status': this.status.toString().split('.').last,
      'halfPortion': this.halfPortion,
      'orderTime': this.orderTime.toIso8601String(),
      'ingredientPhoto': this.ingredientPhoto,
    };
  }

  CartLine copyWith({
    int? cartLineId,
    int? orderId,
    String? tableName,
    int? tableId,
    int? ingredientId,
    String? ingredientName,
    double? quantity,
    double? price,
    OrderStatus? status,
    bool? halfPortion,
    DateTime? orderTime,
    String? ingredientPhoto,
  }) {
    return CartLine(
      cartLineId: cartLineId ?? this.cartLineId,
      orderId: orderId ?? this.orderId,
      tableName: tableName ?? this.tableName,
      tableId: tableId ?? this.tableId,
      ingredientId: ingredientId ?? this.ingredientId,
      ingredientName: ingredientName ?? this.ingredientName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      status: status ?? this.status,
      halfPortion: halfPortion ?? this.halfPortion,
      orderTime: orderTime ?? this.orderTime,
      ingredientPhoto: ingredientPhoto ?? this.ingredientPhoto,
    );
  }
}
