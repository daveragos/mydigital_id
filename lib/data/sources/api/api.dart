// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:mydigital_id/app/constants/api_const.dart';

class Api {
  Future<Response> login(String email, String password) async {
    //create dummy login data
    print('THE STATUS CODE');
    final loginData = {
      'email': 'testt@gmail.com',
      'password': '12345678',
    };

    //send login request
    final response = await Dio().post(
      ApiConst.login,
      data: loginData,
    );
    print('THE STATUS CODE IS : ${response.statusCode}');
    return response;
    // final response = await Dio().post(
    //   ApiConst.api + ApiConst.login,
    //   data: {
    //     'email': email,
    //     'password': password,
    //   },
    // );
    // print('RESPONSE ========== $response');
    // return response;
  }
  // Future<Response> register(String name, String email, String password) async {
  //   return await dio.post(
  //     ApiConst.register,
  //     data: {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //     },
  //   );
  // }
}
