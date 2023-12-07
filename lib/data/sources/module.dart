import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/data/sources/api/api.dart';
import 'package:mydigital_id/data/sources/local/user_localdb_impl.dart';

final useLocalDBProvider = Provider<UserLocalDBImpl>((ref) {
  return UserLocalDBImpl();
});

final apiProvider = Provider<Api>((ref) {
  return Api();
});
