import 'package:mydigital_id/data/model/user_model.dart';
import 'package:mydigital_id/data/sources/api/api.dart';
import 'package:mydigital_id/data/sources/local/user_localdb.dart';
import 'package:mydigital_id/domain/entities/user.dart';
import 'package:mydigital_id/domain/repositories/user_repo.dart';

class UserRepoImpl extends UserRepo {
  UserRepoImpl(this.userLocalDB, this.api);
  final UserLocalDB userLocalDB;
  final Api api;

  @override
  Future<List<User>> getUser() async {
    final userModels = await userLocalDB.read();
    return userModels!.map((userModel) => userModel.toEntity()).toList();
  }

  @override
  Future<User> login(String email, String password) async {
    final response = await api.login(email, password);
    if (response.statusCode == 200) {
      // Extract the 'user' map from the response data
      final userMap = response.data['user'];
      // Pass the 'user' map to UserModel.fromJson
      final userModel = UserModel.fromJson(userMap);
      return userModel.toEntity();
    } else {
      throw Exception('Failed to login');
    }
  }
}
