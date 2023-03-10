import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutProvider with ChangeNotifier {
  Future<void> logoutProvider() async {
    final url = Uri.parse(Api.url + Api.logout);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var response = await http.post(
        url,
        body: jsonEncode({}),
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
      );
      print('responseData');
      print(jsonDecode(response.body));
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
