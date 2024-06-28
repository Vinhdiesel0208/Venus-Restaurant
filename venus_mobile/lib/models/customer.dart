import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Customer {
  @JsonKey(name: 'full_name')
  final String fullName;

  final String email;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  final String password;

  Customer({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
    };

// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
// class Customer {
//   final String fullName;
//   final String email;
//   final String phoneNumber;
//   final String password;

//   Customer({
//     required this.fullName,
//     required this.email,
//     required this.phoneNumber,
//     required this.password,
//   });

//   factory Customer.fromJson(Map<String, dynamic> json) =>
//       _$CustomerFromJson(json);
//   Map<String, dynamic> toJson() => _$CustomerToJson(this);
// }

// Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
//       fullName: json['name'] as String,
//       email: json['email'] as String,
//       phoneNumber: json['phoneNumber'] as String,
//       password: json['password'] as String,
//     );

// Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
//       'name': instance.fullName,
//       'email': instance.email,
//       'phoneNumber': instance.phoneNumber,
//       'password': instance.password,
//     };
