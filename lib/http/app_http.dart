import 'dart:convert';
import 'package:alofo/classes/app_response.dart';
import 'package:alofo/functions/get_headers.dart';
import 'package:alofo/functions/get_uri.dart';
import 'package:alofo/states/app_http_state.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

String apiUrl = "http://192.168.8.102:8000/api";

class AppHttp {
  static Future<AppResponse> get(String uri) {
    var appHttpState = Get.find<AppHttpState>();
    return appHttpState.convertToAppResponse(
      () async => http.get(
        getUri(baseUrl: apiUrl, uri: uri),
        headers: await getHeaders(),
      ),
    );
  }

  static Future<AppResponse> post(String uri, Object? payload) {
    var appHttpState = Get.find<AppHttpState>();
    var body = payload != null ? jsonEncode(payload) : null;

    return appHttpState.convertToAppResponse(
      () async => http.post(
        getUri(baseUrl: apiUrl, uri: uri),
        headers: await getHeaders(),
        body: body,
      ),
    );
  }
}
