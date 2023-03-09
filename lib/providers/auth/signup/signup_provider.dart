import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:dream_access/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider with ChangeNotifier {
  String _email = '';
  String get email => _email;
  // int _isEmai
  User _user = User(
    id: 0,
    name: 'User name',
    email: 'email',
    image: '',
    phoneNumber: 'phoneNumber',
    nationality: 'nationality',
    birthDate: '',
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
      // SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['access_token']);
      prefs.setInt('id', responseData['user']['id']);
      prefs.setString('name', responseData['user']['name']);
      prefs.setString('image', responseData['user']['image']);
      prefs.setString('phone', responseData['user']['email']);
      prefs.setString('birthDay', responseData['user']['birthday'] ?? '');
      prefs.setString('nationality', responseData['user']['nationality'] ?? '');
      prefs.setString('birthday', responseData['user']['birthday'] ?? '');
      // User
      _user = User(
        id: responseData['user']['id'],
        name: responseData['user']['name'],
        email: responseData['user']['email'] ?? '',
        image: responseData['user']['image'],
        phoneNumber: responseData['user']['phone'] ?? '',
        nationality: '',
        birthDate: '',
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
