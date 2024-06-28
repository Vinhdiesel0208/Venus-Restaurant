// lib/models/contact.dart

class Contact {
  final String? id;  // Sử dụng String? nếu id có thể là null
  final String fullName;
  final String email;
  final String phone;
  final String message;
  final DateTime createdTime;
  final String? adminResponse;

  Contact({
    this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.message,
    required this.createdTime,
    this.adminResponse,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String?,  // Cast kiểu dữ liệu cho phù hợp
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      message: json['message'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
      adminResponse: json['adminResponse'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'message': message,
      'createdTime': createdTime.toIso8601String(),
      'adminResponse': adminResponse,
    };
  }
}
