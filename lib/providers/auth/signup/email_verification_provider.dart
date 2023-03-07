import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api.dart';
import '../../../models/http_exception.dart';

class EmailVerificationProvider with ChangeNotifier {
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
      if (responseData['userId'] is int) {
        print('User exist');
        throw HttpException(message: 'User Exist');
      }
      _code = responseData['code'];
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
