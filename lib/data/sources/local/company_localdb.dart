import 'package:mydigital_id/data/model/company_model.dart';

abstract class CompanyLocalDB {
  Future<List<CompanyModel>?> read();
}
