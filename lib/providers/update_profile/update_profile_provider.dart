import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileProvider with ChangeNotifier {
  Map<String, dynamic> _map = {
    'name': '',
    'email': '',
    'phone': '',
    'nationality': ''
  };
  Map<String, dynamic> get map => _map;
  String _name = '';
  String get name => _name;

  Future<void> updateProfileFct() async {
    final url = Uri.parse(Api.url + Api.editProfile);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(_map),
      );
      var responseData = jsonDecode(response.body);
      print('responseData');
      print(responseData);
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
    }
  }

  void updateMap(String name, String email, String phone, String nationality) {
    _map = {'name': '', 'email': '', 'phone': '', 'nationality': ''};
    notifyListeners();
  }

  void imageFct(String name) async {
    _name = name;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
    notifyListeners();
  }
}
