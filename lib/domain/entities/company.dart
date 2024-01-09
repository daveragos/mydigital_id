import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
class Company with _$Company {
  factory Company({
    required String name,
    required String role,
    required String email,
    required String address,
    required String phoneNumber,
    required String qr,
    required String logo,
    required String exp,
    required double rating,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
