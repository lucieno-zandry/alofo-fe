import '../models/models.dart' as models;

Future<Map<String, bool>> getEmailInfo(String email) async {
  return Future.delayed(Duration(seconds: 1), () => {'is_taken': false});
}

Future<Map<String, dynamic>> matchConfirmationCode(String code) async {
  return Future.delayed(
    Duration(seconds: 1),
    // () => {
    //   'errors': {
    //     'email': ['The code is not valid'],
    //   },
    // },
    () => {
      'data': {'has_matched': true},
    },
  );
}

Future<Map<String, dynamic>> logIn(String email, String password) async {
  return Future.delayed(
    Duration(seconds: 1),
    () => {
      'data': {
        'user': {
          'id': 1,
          'name': "john doe",
          'email': "john@doe.com",
          'email_verified_at': "2025-07-07 12:00:00",
          'approved_at': "2025-07-07 12:00:00",
          'created_at': "2025-07-07 12:00:00",
          'updated_at': "2025-07-07 12:00:00",
          'address_id': null,
          'client_code_id': null,
          'role': 'client',
          'image': null,
        },
        'token': 'this is a token',
      },
    },
  );
}

Future<Map<String, dynamic>> register(String email) async {
  return Future.delayed(Duration(seconds: 1), () => {});
}

Future<Map<String, dynamic>> updateUser(models.User user) async {
  return Future.delayed(
    Duration(seconds: 1),
    () => {
      'data': {'user': user.toJson()},
    },
  );
}
