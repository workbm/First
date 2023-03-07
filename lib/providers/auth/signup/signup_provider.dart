import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:dream_access/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SignUpProvider with ChangeNotifier {
  String _email = '';
  String get email => _email;
  User _user = User(
    id: 0,
    name: 'User name',
    email: 'email',
    phoneNumber: 'phoneNumber',
    nationality: 'nationality',
    birthDate: DateTime.now(),
  );
  User get user => _user;

  Future<void> signupFct(String password) async {
    final url = Uri.parse(Api.url + Api.signUP);
    try {
      var response = await http.post(
        url,
        body: jsonEncode(
          {
            "name": "User name",
            "password": password,
            "password_confirmation": password,
            "email": _email
          },
        ),
        headers: Api.headers,
      );
      var responseData = jsonDecode(response.body);
      print('responseData');
      print(responseData);
      _user = User(
        id: responseData['user']['id'],
        name: responseData['user']['name'],
        email: responseData['user']['email'] ?? '',
        phoneNumber: responseData['user']['phone'] ?? '',
        nationality: '',
        birthDate: DateTime.now(),
      );
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  void getEmail(String email) {
    _email = email;
    notifyListeners();
  }
}
