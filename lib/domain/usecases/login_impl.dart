import 'package:mydigital_id/domain/entities/user.dart';
import 'package:mydigital_id/domain/repositories/user_repo.dart';
import 'package:mydigital_id/domain/usecases/login.dart';

class LoginUseCaseImpl extends LoginUseCase {
  LoginUseCaseImpl(this.userRepo);
  final UserRepo userRepo;
  @override
  Future<User> call(String email, String password) async {
    return await userRepo.login(email, password);
  }
}
