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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final color = context.colorScheme;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/images/Asset1.png'),
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
                          'Register',
                          style: text.headlineLarge,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //photo picker
                      CircleAvatar(
                        radius: 50,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFField(
                          icon: Icons.abc_rounded,
                          controller: firstNameController,
                          hintText: 'enter your first name',
                          labelText: 'First Name'),
                      const SizedBox(height: 20),
                      TextFField(
                          icon: Icons.abc_rounded,
                          controller: lastNameController,
                          hintText: 'enter your last name',
                          labelText: 'Last Name'),
                      const SizedBox(height: 20),
                      TextFField(
                        icon: Icons.location_on_rounded,
                        controller: addressController,
                        hintText: 'enter your address',
                        labelText: 'Address',
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFField(
                          icon: Icons.phone,
                          controller: phoneNumberController,
                          hintText: 'enter your phone number',
                          labelText: 'Phone Number',
                          keyboardType: TextInputType.phone),
                      const SizedBox(height: 20),
                      TextFField(
                        icon: Icons.email,
                        controller: emailController,
                        hintText: 'enter your email',
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFField(
                        icon: Icons.lock,
                        controller: passwordController,
                        hintText: 'enter your password',
                        labelText: 'Password',
                        hide: true,
                      ),
                      const SizedBox(height: 20),
                      TextFField(
                        icon: Icons.lock_reset,
                        controller: confirmPasswordController,
                        hintText: 'confirm your password',
                        labelText: 'Confirm',
                        hide: true,
                      ),
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
                            // _register();
                          }
                        },
                        child: const Text('Register'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              child: const Text("Have an Account? Login"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    try {
      const url = 'Users';
      final data = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'address': addressController.text,
        'phoneNumber': phoneNumberController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };
      final response =
          await APIPost().postRequest(route: url, data: data, context: context);
      if (response.statusCode == 200) {
        context.pop();
      } else {
        print('status code : ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
