import 'package:alofo/classes/app_response.dart';
import 'package:alofo/functions/handle_response_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppHttpState extends GetxController {
  final BuildContext context;

  AppHttpState({required this.context});

  Future<AppResponse> Function(Future<http.Response> Function())
  get convertToAppResponse => (request) async {
    var httpResponse = await request();
    var response = AppResponse(httpResponse: httpResponse);

    if (response.statusCode < 200 || response.statusCode >= 400) {
      if (response.statusCode == 403 &&
          response.data?['action'] != null &&
          context.mounted) {
        handleResponseAction(context: context, response: response);
      } else {
        throw response.data as Object;
      }
    }

    return response;
  };
}
