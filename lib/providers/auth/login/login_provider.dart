import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:dream_access/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  User _user = User(
      id: 0,
      name: 'name',
      email: 'email',
      phoneNumber: 'phoneNumber',
      nationality: 'nationality',
      birthDate: DateTime.now());
  User get user => _user;
  Future<void> loginFct(String email, String password) async {
    print('email: $email');
    print('password:$password');
    try {
      var url = Uri.parse(Api.url + Api.login);
      var response = await http.post(
        url,
        headers: Api.headers,
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      var responseData = json.decode(response.body);
      print('responseData');
      print(responseData);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['access_token']);
      _user = User(
        id: responseData['user']['id'],
        name: responseData['user']['name'] ?? '',
        email: responseData['user']['email'] ?? '',
        phoneNumber: responseData['user']['phone'] ?? '',
        nationality: responseData['user']['nationality'] ?? '',
        birthDate: DateTime.now(),
      );
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
