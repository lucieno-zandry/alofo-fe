import 'package:alofo/classes/local_storage.dart';

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
