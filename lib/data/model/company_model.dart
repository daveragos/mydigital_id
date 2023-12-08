import 'package:mydigital_id/domain/entities/company.dart';

class CompanyModel {
  //todo add expiration date for the id of the user of that company
  String name;
  String email;
  String role;
  String address;
  String phoneNumber;
  String qr;
  String logo;
  //todo String exp;

  CompanyModel({
    required this.name,
    required this.role,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.qr,
    required this.logo,
    //todo required this.exp
  });

  factory CompanyModel.fromEntity(Company company) => CompanyModel(
        name: company.name,
        role: company.role,
        email: company.email,
        address: company.address,
        phoneNumber: company.phoneNumber,
        qr: company.qr,
        logo: company.logo,
        //todo exp: company.exp
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
      //todo exp:exp
    );
  }
}
