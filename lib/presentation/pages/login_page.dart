// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mydigital_id/app/constants/path_const.dart';
import 'package:mydigital_id/app/constants/shared_const.dart';
import 'package:mydigital_id/app/theme/theme.dart';
import 'package:mydigital_id/data/sources/api/api_post.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:mydigital_id/presentation/widgets/textFField_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final color = context.colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/Asset4.png'),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: color.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFField(
                        icon: Icons.email_rounded,
                        controller: emailController,
                        hintText: 'enter your email',
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFField(
                          icon: Icons.lock_rounded,
                          controller: passwordController,
                          hintText: 'enter your password',
                          labelText: 'Password',
                          hide: true),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color.secondaryContainer,
                          foregroundColor: color.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _login();
                          }
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                GoRouter.of(context)
                                    .push(PathConst.registerPath);
                              },
                              child:
                                  const Text("Don't have an Account? Sign Up"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/Intersect1.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    try {
      const url = 'user-login';
      final data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      final response =
          await APIPost().postRequest(route: url, data: data, context: context);
      if (response.statusCode == 200) {
        var responseData = response.data['user'];
        String userJson = jsonEncode(responseData);
        //change the user to usermodel then to entity
        //todo storing the user and token working
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString(
          SharedConst.user,
          userJson,
        );
        await pref.setString(
            SharedConst.token, response.data['token'].toString());
        context.go(PathConst.digitalIdPath);
      } else {
        print('status code : ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
