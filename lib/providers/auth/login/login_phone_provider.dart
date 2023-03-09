import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:dream_access/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPhoneProvider with ChangeNotifier {
  User _user = User(
      id: 0,
      name: 'name',
      email: 'email',
      image: '',
      phoneNumber: 'phoneNumber',
      nationality: 'nationality',
      birthDate: '');
  User get user => _user;
  Future<void> loginFct(String phone, String password) async {
    print('email: $phone');
    print('password:$password');
    try {
      var url = Uri.parse(Api.url + Api.login);
      var response = await http.post(
        url,
        headers: Api.headers,
        body: json.encode({
          'phone': phone,
          'password': password,
        }),
      );
      var responseData = json.decode(response.body);
      print('responseData');
      print(responseData);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['access_token']);
      prefs.setInt('id', responseData['user']['id']);
      prefs.setString('name', responseData['user']['name']);
      prefs.setString('image', responseData['user']['image']);
      prefs.setString('phone', responseData['user']['phone']);
      prefs.setString('birthDay', responseData['user']['birthday'] ?? '');
      prefs.setString('nationality', responseData['user']['nationality'] ?? '');

      _user = User(
        id: responseData['user']['id'],
        name: responseData['user']['name'] ?? '',
        email: responseData['user']['email'] ?? '',
        image: responseData['user']['image'],
        phoneNumber: responseData['user']['phone'] ?? '',
        nationality: responseData['user']['nationality'] ?? '',
        birthDate: responseData['user']['birthday'] ?? '',
      );
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
