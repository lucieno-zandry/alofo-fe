import 'package:alofo/http/app_http.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';

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
  Map<String, String?> params = Get.parameters;
  String? token = params['token'];

  return AppHttp.post('/auth/user/update', {...data, 'token': token});
}

Future<AppResponse> sendConfirmationCode() {
  return AppHttp.get('/auth/email/confirm');
}

Future<AppResponse> sendPasswordResetLink(String email) {
  return AppHttp.post('/auth/password/forgot', {'email': email});
}
