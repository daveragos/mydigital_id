// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mydigital_id/app/utils/alert_dialog.dart' as alert;
import 'package:mydigital_id/app/utils/api_exceptions.dart';

class APIPost {
  alert.AlerterDialog alertDialog = alert.AlerterDialog();
  postRequest(
      {required String route,
      required Map<String, String> data,
      required BuildContext context}) async {
    //use dio package
    const baseUrl = 'https://portal.my-digitalid.com/api/';
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    // handle all errors that could occur using try catch
    try {
      final response = await dio.post(route, data: data);
      print(response.statusCode);
      return response;
    } on DioException catch (e) {
      checkException(e, context);
    } catch (e) {
      alertDialog.showAlert(
          context: context, title: 'Error', content: e.toString());
    }
  }

  getRequest(
      {required String route,
      required String token,
      required BuildContext context}) async {
    //use dio package
    const baseUrl = 'https://admin.my-digitalid.com/api/';
    final dio = Dio(BaseOptions(
        baseUrl: baseUrl, headers: {"Authorization": "Bearer $token"}));
    //handle all errors that could occur using try catch
    try {
      final response = await dio.get(route);
      return response;
    } on DioException catch (e) {
      checkException(e, context);
    } catch (e) {
      alertDialog.showAlert(
          context: context, title: 'Error', content: e.toString());
    }
  }

  void checkException(DioException error, BuildContext context) {
    APIException exception = APIException();
    final List<String> message = exception.getExceptionMessage(error);
    alertDialog.showAlert(
      context: context,
      title: message[0],
      content: message[1],
    );
  }
}
