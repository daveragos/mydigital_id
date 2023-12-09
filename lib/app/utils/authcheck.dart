// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/constants/shared_const.dart';
import 'package:mydigital_id/presentation/pages/home_card_page.dart';
import 'package:mydigital_id/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends ConsumerStatefulWidget {
  const AuthCheck({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthCheckState();
}

class _AuthCheckState extends ConsumerState<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            final token = snapshot.data!.getString(SharedConst.token);
            if (token != null) {
              return HomeCardScreen();
            } else {
              return LoginScreen();
            }
          } else if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Some Error Occured')));
          } else {
            return LoginScreen();
          }
        });
  }
}
