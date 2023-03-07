import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../constants/api.dart';

class StatisticsProvider with ChangeNotifier {
  Future<void> staticsFct(int statisticId, int carID) async {
    final url = Uri.parse('${Api.url}${Api.statistique}$statisticId');
    try {
      print('carID:$carID');
      var response = await http.post(
        url,
        body: json.encode({
          'car_id': carID,
        }),
        headers: {
          'Content-Type': 'multipart/json',
        },
      );
      var responseData = json.decode(response.body);
      print(' Statistics responseData');
      print(responseData);
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
