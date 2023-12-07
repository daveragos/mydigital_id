import 'package:mydigital_id/domain/entities/user.dart';

abstract class GetUsersUseCase {
  Future<List<User>> call();
}
