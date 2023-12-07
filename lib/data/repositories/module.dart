import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/data/repositories/user_repo_impl.dart';
import 'package:mydigital_id/data/sources/module.dart';
import 'package:mydigital_id/domain/repositories/user_repo.dart';

final userProvider = Provider<UserRepo>((ref) {
  return UserRepoImpl(ref.read(useLocalDBProvider), ref.read(apiProvider));
});
