import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SaveWishlistProvider with ChangeNotifier {
  Future<void> saveWishlistFct(int carId) async {
    var url = Uri.parse(Api.url + Api.saveToWishist);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var response = await http.post(
        url,
        body: jsonEncode(
          {"car_id": carId},
        ),
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token'
        },
      );
      var responseData = jsonDecode(response.body);
      print('responseData');
      print(responseData);
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
