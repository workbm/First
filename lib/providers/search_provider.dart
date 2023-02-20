import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:dream_access/models/car_search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  List<CarSearch> _cars = [];
  List<CarSearch> get cars => _cars;
  bool _isSearchPressed = false;
  bool get isSearchedPressed => _isSearchPressed;
  Future<void> searchFct(String carName) async {
    final url = Uri.parse(Api.url + Api.search);
    try {
      print('carName:$carName');
      var response = await http.post(
        url,
        body: json.encode({
          'keyword': carName,
        }),
        headers: {
          'Content-Type': 'multipart/json',
        },
      );
      var responseData = json.decode(response.body);
      List<CarSearch> loadedCars = [];
      for (var element in responseData) {
        loadedCars.add(
          CarSearch(id: element['id'], name: element['name']),
        );
      }
      print('responseData');
      print(responseData);
      _cars = loadedCars;
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  void searchPressedFct(bool isPressed) {
    _isSearchPressed = isPressed;
    notifyListeners();
  }
}
