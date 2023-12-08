// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mydigital_id/app/constants/path_const.dart';
import 'package:mydigital_id/app/theme/theme.dart';
import 'package:mydigital_id/app/utils/api_post.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:mydigital_id/data/model/user_model.dart';
import 'package:mydigital_id/domain/entities/company.dart';
import 'package:mydigital_id/domain/entities/user.dart';
import 'package:mydigital_id/presentation/providers/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<Company> listOfCompanies = [
    Company(
      name: 'google',
      role: 'ceo',
      email: 'google@gmail.com',
      address: 'silicon',
      phoneNumber: '09****09',
      qr: '09****09',
      logo: '09****09',
    ),
    Company(
      name: 'facebook',
      role: 'marketting',
      email: 'facebook@gmail.com',
      address: 'silicon',
      phoneNumber: '09****09',
      qr: '09****09',
      logo: '09****09',
    ),
    Company(
      name: 'amazon',
      role: 'sales',
      email: 'amazon@gmail.com',
      address: 'silicon',
      phoneNumber: '09****09',
      qr: '09****09',
      logo: '09****09',
    ),
    Company(
      name: 'apple',
      role: 'cto',
      email: 'apple@gmail.com',
      address: 'silicon',
      phoneNumber: '09****09',
      qr: '09****09',
      logo: '09****09',
    ),
    Company(
      name: 'microsoft',
      role: 'freelancer',
      email: 'microsoft@gmail.com',
      address: 'silicon',
      phoneNumber: '09****09',
      qr: '09****09',
      logo: '09****09',
    ),
    Company(
      name: 'twitter',
      role: 'intern',
      email: 'twitter@gmail.com',
      address: 'silicon',
      phoneNumber: '09****09',
      qr: '09****09',
      logo: '09****09',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final color = context.colorScheme;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
                        'Login',
                        style: text.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: const InputDecoration(
                        iconColor: primaryColor,
                        fillColor: primaryColor,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red),
                        hintText: 'Enter your email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        focusColor: primaryColor,
                        filled: true,
                        fillColor: primaryColor,
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        labelText: 'Password',
                        helperStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.red),
                        hintText: 'Enter your password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
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
                          _login();
                        }
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("Don't have an Account? Sign Up"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * .35,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/Intersect1.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
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
        //change the user to usermodel then to entity
        //todo no working
        UserModel userModel = UserModel.fromJson(responseData);
        User userEntity = userModel.toEntity();
        ref.read(userStateProvider.notifier).state = userEntity;
        ref.read(companyProvider.notifier).state = listOfCompanies;
        ref.read(selectedCompanyProvider.notifier).state = 0;
        context.go(PathConst.digitalIdPath);
        print('UserModel: ${userModel.address} AAANNNNNDDDDD userr');
        print('User: $userEntity AAANNNNNDDDDD ');
      } else {
        print('status code : ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
