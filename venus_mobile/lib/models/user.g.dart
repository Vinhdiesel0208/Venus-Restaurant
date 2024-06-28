// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';



User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      fullName: json['fullName'] as String,
      photo: json['photo'] as String,
      photosImagePath: json['photosImagePath'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'photo': instance.photo,
      'photosImagePath': instance.photosImagePath,
    };
