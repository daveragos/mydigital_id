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

  Future<Response> getRequest(
      {required String route,
      required String token,
      required BuildContext context}) async {
    //use dio package
    const baseUrl = 'https://portal.my-digitalid.com/api/';
    final dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {"Authorization": "Bearer $token"},
        validateStatus: (status) {
          return status! < 500;
        }));
    try {
      final response = await dio.get(route);
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 404) {
        final customResponse = Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          data: {
            "company_name": "MyDigital ID",
            "company_email": "support@mydigitalid.com",
            "company_address": "Megenagn",
            "company_phone": "582801545",
            "position": "Support",
            "qr_code_url": "assets/images/Asset2.png",
            "card_expire_date": "0000-00-00",
            "company_logo": "assets/images/Asset3.png"
          },
        );
        return customResponse;
      } else {
        alertDialog.showAlert(
          context: context,
          title: 'Error',
          content: 'Unexpected status code: ${response.statusCode}',
        );
      }
      return response;
    } on DioException catch (e) {
      checkException(e, context);
      rethrow; // Add this line to rethrow the exception
    } catch (e) {
      alertDialog.showAlert(
          context: context, title: 'Error', content: e.toString());
      rethrow; // Add this line to rethrow the exception
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
