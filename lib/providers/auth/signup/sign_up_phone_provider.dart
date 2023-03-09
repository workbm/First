import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/api.dart';
import 'package:http/http.dart' as http;
import '../../../models/user.dart';

class SignUpPhoneProvider with ChangeNotifier {
  String _phone = '';
  String get phone => _phone;
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
            "phone": _phone
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
      prefs.setString('phone', responseData['user']['phone']);
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

  void getPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }
}
