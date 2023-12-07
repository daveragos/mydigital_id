import 'package:mydigital_id/domain/entities/user.dart';

abstract class LoginUseCase {
  Future<User> call(String email, String password);
}
