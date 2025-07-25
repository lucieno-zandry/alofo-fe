import 'package:alofo/classes/app_response.dart';
import 'package:http/http.dart' as http;

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
