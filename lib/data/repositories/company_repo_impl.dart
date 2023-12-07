import 'package:mydigital_id/data/sources/local/company_localdb.dart';
import 'package:mydigital_id/domain/entities/company.dart';
import 'package:mydigital_id/domain/repositories/company_repo.dart';

class CompanyRepoImpl extends CompanyRepo {
  CompanyRepoImpl(this.companyLocalDB);
  final CompanyLocalDB companyLocalDB;

  @override
  Future<List<Company>> getCompany() async {
    final userModels = await companyLocalDB.read();
    return userModels!.map((userModel) => userModel.toEntity()).toList();
  }
}
