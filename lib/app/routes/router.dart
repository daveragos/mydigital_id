import 'package:go_router/go_router.dart';
import 'package:mydigital_id/presentation/pages/home_card_page.dart';
import 'package:mydigital_id/presentation/pages/profile_page.dart';
import '../constants/path_const.dart';
import '../../presentation/pages/login_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: PathConst.digitalIdPath,
      name: 'home_card',
      builder: (context, state) => const CreditCardScreen(),
    ),
    GoRoute(
      path: PathConst.profilePath,
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    )
  ],
);
