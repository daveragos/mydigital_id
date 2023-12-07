import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/data/repositories/module.dart';
import 'package:mydigital_id/domain/usecases/get_user_impl.dart';
import 'package:mydigital_id/domain/usecases/login_impl.dart';

final getUserProvider = Provider<GetUsersUseCaseImpl>((ref) {
  return GetUsersUseCaseImpl(ref.read(userProvider));
});

final loginProvider = Provider<LoginUseCaseImpl>((ref) {
  return LoginUseCaseImpl(ref.read(userProvider));
});
