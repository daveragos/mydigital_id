import 'package:mydigital_id/domain/entities/company.dart';

abstract class CompanyRepo {
  Future<List<Company>> getCompany();
}
