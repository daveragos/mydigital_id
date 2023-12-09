import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/company.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/module.dart';

class UserStateNotifier extends StateNotifier<List<User>> {
  UserStateNotifier(this.ref) : super([]) {
    getUsers();
  }
  final Ref ref;
  late final getUsersProvider = ref.read(getUserProvider);

  Future<void> getUsers() async {
    state = await getUsersProvider.call();
  }

  Future<User> login(String email, String password) async {
    return await ref.read(loginProvider).call(email, password);
  }
}

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, List<User>>(
        (ref) => UserStateNotifier(ref));

final userStateProvider = StateProvider<User>((ref) {
  return User(
    id: '0',
    first_name: '',
    last_name: '',
    email: '',
    phone_number: '56465',
    address: '',
    profile_pic_url: '',
  );
});

final selectedCompanyProvider = StateProvider<int>((ref) {
  return 0;
});

final companyProvider = StateProvider<List<Company>>((ref) {
  return [];
});
