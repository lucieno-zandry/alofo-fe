import 'package:alofo/classes/app_response.dart';
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

Future<AppResponse> resetPassword({
  required String password,
  required String token,
  required String passwordConfirmation,
}) {
  return AppHttp.post('/auth/password/reset', {
    'password': password,
    'token': token,
    'password_confirmation': passwordConfirmation,
  });
}

Future<AppResponse> updateUser(Map<String, dynamic> data) {
  return AppHttp.post('/auth/user/update', data);
}

Future<AppResponse> sendConfirmationCode() {
  return AppHttp.get('/auth/email/confirm');
}

Future<AppResponse> sendPasswordResetLink(String email) {
  return AppHttp.post('/auth/password/forgot', {'email': email});
}

Future<AppResponse> getAuthUser() {
  return AppHttp.get('/auth/user/get');
}
