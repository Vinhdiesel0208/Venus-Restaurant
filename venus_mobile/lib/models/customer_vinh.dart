class Customer {
  final String fullName;
  final String email;
  final int points;

  Customer({required this.fullName, required this.email, required this.points});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      fullName: json['fullName'],
      email: json['email'],
      points: json['points'],
    );
  }
}
