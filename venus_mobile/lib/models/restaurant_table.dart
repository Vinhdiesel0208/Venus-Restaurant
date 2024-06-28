class RestaurantTable {
  final int id;
  final String tableNumber;
  final bool status;
  final int online;
  final int seatCount;
  final double price;
  final String categoryName;

  RestaurantTable({
    required this.id,
    required this.tableNumber,
    required this.status,
    required this.online,
    required this.seatCount,
    required this.price,
    required this.categoryName,
  });

  factory RestaurantTable.fromJson(Map<String, dynamic> json) {
    return RestaurantTable(
      id: json['id'],
      tableNumber: json['tableNumber'],
      status: json['status'],
      online: json['online'] ?? 0,
      seatCount: json['seatCount'] ?? 0,
      price: json['price']?.toDouble() ?? 0.0,
      categoryName: json['category']?['categoryName'] ?? 'Unknown',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tableNumber': tableNumber,
      'status': status,
      'online': online,
      'seatCount': seatCount,
      'categoryName': categoryName,
      'price': price,
    };
  }
}
