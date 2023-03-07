import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api.dart';
import '../../../models/http_exception.dart';

class SendEmailProvider with ChangeNotifier {
  int _userId = 0;
  int get userId => _userId;
  int _code = 0;
  int get code => _code;

  Future<void> emailVerificationFct(String email) async {
    print('emailVerification');
    var url = Uri.parse(Api.url + Api.emailVerification);
    try {
      var response = await http.post(url,
          headers: Api.headers,
          body: jsonEncode({
            'email': email,
          }));
      var responseData = jsonDecode(response.body);
      print('responseDataEmailVerification $responseData');
      print('code: ${responseData['code']}');
      if (responseData['userId'] is String) {
        print('User doesnot exist');
        throw HttpException(message: 'The user does not exist');
      }
      _userId = responseData['userId'];
      _code = responseData['code'];
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  Future<void> updatePasswordFct(String password) async {
    var url = Uri.parse(Api.url + Api.updatePassword);
    try {
      var response = await http.post(url,
          headers: Api.headers,
          body: jsonEncode(
            {"userId": _userId, "password": password},
          ));
      var responseData = jsonDecode(response.body);
      print('responseData');
      print(responseData);
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
