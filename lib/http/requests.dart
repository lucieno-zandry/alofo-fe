import 'package:alofo/http/app_http.dart';

Future<AppResponse> getEmailInfo(String email) {
  return AppHttp.post('/auth/email/info', {'email': email});
}

Future<AppResponse> matchConfirmationCode(String code) {
  return AppHttp.post('/auth/email/verify', {'code': code});
}

Future<AppResponse> logIn(String email, String password) {
  return AppHttp.post('/auth/login', {'email': email, 'password': password});
}

Future<AppResponse> register(String email) {
  String name = 'New User';

  return AppHttp.post('/auth/register', {'email': email, 'name': name});
}

Future<AppResponse> updateUser(Map<String, dynamic> data) {
  return AppHttp.post('/auth/user/update', data);
}

Future<AppResponse> sendConfirmationCode() {
  return AppHttp.get('/auth/email/confirm');
}
