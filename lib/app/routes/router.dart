import 'package:go_router/go_router.dart';
import 'package:mydigital_id/app/utils/authcheck.dart';
import 'package:mydigital_id/presentation/pages/home_card_page.dart';
import 'package:mydigital_id/presentation/pages/profile_page.dart';
import 'package:mydigital_id/presentation/pages/register_page.dart';
import '../constants/path_const.dart';
import '../../presentation/pages/login_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'AuthCheck',
      builder: (context, state) => const AuthCheck(),
    ),
    GoRoute(
      path: PathConst.loginPath,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: PathConst.registerPath,
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: PathConst.digitalIdPath,
      name: 'home_card',
      builder: (context, state) => const HomeCardScreen(),
    ),
    GoRoute(
      path: PathConst.profilePath,
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    )
  ],
);
