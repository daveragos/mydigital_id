import 'package:mydigital_id/data/model/user_model.dart';
import 'package:mydigital_id/data/sources/local/user_localdb.dart';

class UserLocalDBImpl extends UserLocalDB {
  @override
  Future<List<UserModel>?> read() async {
    // return dummy data
    List<UserModel> dummy = [];
    return dummy;
  }
}
