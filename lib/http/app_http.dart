import 'dart:convert';
import 'package:alofo/classes/local_storage.dart';
import 'package:http/http.dart' as http;

String apiUrl = "http://localhost:8000/api";

Future<Map<String, String>> getHeaders() async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  if (await LocalStorage.containsKey('authorization_token')) {
    String? authorizationToken = await LocalStorage.getItem(
      'authorization_token',
    );
    if (authorizationToken != null) {
      headers['Authorization'] = "Bearer $authorizationToken";
    }
  }

  return headers;
}

class AppResponse {
  const AppResponse({required this.httpResponse});
  final http.Response httpResponse;

  http.BaseRequest? get request => httpResponse.request;
  int get statusCode => httpResponse.statusCode;
  Map<dynamic, dynamic>? get data =>
      jsonDecode(httpResponse.body) as Map<dynamic, dynamic>;
}

Uri getUri(String uri) {
  return Uri.parse("$apiUrl$uri");
}

Future<AppResponse> convertToAppResponse(
  Future<http.Response> Function() request,
) async {
  var httpResponse = await request();
  var response = AppResponse(httpResponse: httpResponse);

  if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 400) {
    throw response.data as Object;
  }

  return response;
}

class AppHttp {
  static Future<AppResponse> get(String uri) {
    return convertToAppResponse(
      () async => http.get(getUri(uri), headers: await getHeaders()),
    );
  }

  static Future<AppResponse> post(String uri, Object? payload) {
    var body = payload != null ? jsonEncode(payload) : null;

    return convertToAppResponse(
      () async =>
          http.post(getUri(uri), headers: await getHeaders(), body: body),
    );
  }
}
