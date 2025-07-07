Future<Map<String, bool>> getEmailInfo(String email) async {
  return Future.delayed(Duration(seconds: 1), () => {'is_taken': false});
}

Future<Map<String, dynamic>> matchConfirmationCode(String code) async {
  return Future.delayed(
    Duration(seconds: 1),
    () => {
      'errors': {
        'email': ['The code is not valid'],
      },
    },
  );
}
