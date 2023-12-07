import 'package:mydigital_id/domain/entities/company.dart';

class CompanyModel {
  String name;
  String email;
  String role;
  String address;
  String phoneNumber;
  String qr;
  String logo;

  CompanyModel({
    required this.name,
    required this.role,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.qr,
    required this.logo,
  });

  factory CompanyModel.fromEntity(Company company) => CompanyModel(
        name: company.name,
        role: company.role,
        email: company.email,
        address: company.address,
        phoneNumber: company.phoneNumber,
        qr: company.qr,
        logo: company.logo,
      );

  Company toEntity() {
    return Company(
      name: name,
      role: role,
      email: email,
      address: address,
      phoneNumber: phoneNumber,
      qr: qr,
      logo: logo,
    );
  }
}
