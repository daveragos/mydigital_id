// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:mydigital_id/domain/entities/user.dart';

class UserModel {
  //todo naming conventions from api naming to everything
  String id;
  String first_name;
  String last_name;
  String email;
  String phone_number;
  String address;
  String profile_pic_url;

  UserModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone_number,
    required this.address,
    required this.profile_pic_url,
  });

  factory UserModel.fromEntity(User user) => UserModel(
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        phone_number: user.phone_number,
        email: user.email,
        address: user.address,
        profile_pic_url: user.profile_pic_url,
      );

  User toEntity() {
    return User(
        id: id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        phone_number: phone_number,
        address: address,
        profile_pic_url: profile_pic_url);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone_number': phone_number,
      'address': address,
      'profile_pic_url': profile_pic_url
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      email: map['email'] as String,
      phone_number: map['phone_number'] as String,
      address: map['address'] as String,
      profile_pic_url: map['profile_pic_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(Map<String, dynamic> source) =>
      UserModel.fromMap(source);
}
