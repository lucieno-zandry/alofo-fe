import 'dart:convert';

import 'package:http/http.dart' as http;

class AppResponse {
  const AppResponse({required this.httpResponse});
  final http.Response httpResponse;

  http.BaseRequest? get request => httpResponse.request;
  int get statusCode => httpResponse.statusCode;
  Map<dynamic, dynamic>? get data =>
      jsonDecode(httpResponse.body) as Map<dynamic, dynamic>;
}