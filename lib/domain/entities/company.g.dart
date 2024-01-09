// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      name: json['name'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      qr: json['qr'] as String,
      logo: json['logo'] as String,
      exp: json['exp'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'qr': instance.qr,
      'logo': instance.logo,
      'exp': instance.exp,
      'rating': instance.rating,
    };
