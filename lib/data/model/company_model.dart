// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:mydigital_id/domain/entities/company.dart';

class CompanyModel {
  String company_name;
  String company_email;
  String company_address;
  String company_phone;
  String position;
  String qr_code_url;
  String card_expire_date;
  String company_logo;

  CompanyModel({
    required this.company_name,
    required this.company_email,
    required this.company_address,
    required this.company_phone,
    required this.position,
    required this.qr_code_url,
    required this.card_expire_date,
    required this.company_logo,
  });

  factory CompanyModel.fromEntity(Company company) => CompanyModel(
        company_name: company.name,
        company_email: company.email,
        company_address: company.address,
        company_phone: company.phoneNumber,
        position: company.role,
        qr_code_url: company.qr,
        card_expire_date: company.exp,
        company_logo: company.logo,
      );

  Company toEntity() {
    return Company(
      name: company_name,
      email: company_email,
      address: company_address,
      phoneNumber: company_phone,
      role: position,
      qr: qr_code_url,
      exp: card_expire_date,
      logo: company_logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'company_name': company_name,
      'company_email': company_email,
      'company_address': company_address,
      'company_phone': company_phone,
      'position': position,
      'qr_code_url': qr_code_url,
      'card_expire_date': card_expire_date,
      'company_logo': company_logo,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      company_name: map['company_name'] as String,
      company_email: map['company_email'] as String,
      company_address: map['company_address'] as String,
      company_phone: map['company_phone'] as String,
      position: map['position'] as String,
      qr_code_url: map['qr_code_url'] as String,
      card_expire_date: map['card_expire_date'] as String,
      company_logo: map['company_logo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(Map<String, dynamic> source) =>
      CompanyModel.fromMap(source);
}
