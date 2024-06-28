import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String fullName;
  final String photo;
  final String photosImagePath;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.fullName,
      required this.photo,
      required this.photosImagePath});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
