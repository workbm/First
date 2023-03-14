import 'dart:convert';

import 'package:dream_access/models/car_models.dart';
import 'package:dream_access/models/location.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/brand.dart';
import '../models/car_color.dart';
import '../models/car_feature.dart';
import '../models/car_type.dart';

class FilterProvider with ChangeNotifier {
  var _isFilterPressed = false;
  bool get filterPressed => _isFilterPressed;

  List<Brand> _brands = [];
  List<Brand> get brands => [..._brands];
  List<CarType> _carType = [];
  List<CarType> get carType => [..._carType];
  List<Location> _states = [];
  List<Location> get states => [..._states];
  var _location = 'All states';
  String get location => _location;
  List<CarColor> _carColors = [];
  List<CarColor> get colors => _carColors;
  List<CarFeature> _features = [];
  List<CarFeature> get features => _features;

  List<CarModels> _modelsById = [];
  List<CarModels> get modelsById => _modelsById;
  List<CarModels> _models = [];
  List<CarModels> get models => _models;

  Future<void> filterFct() async {
    var url = Uri.parse(Api.url + Api.getDataForFilter);
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);
      print('responseData');
      print(responseData['brands']);
      List<Brand> extractedBrands = [];
      List<CarModels> extractedCarModels = [];
      List<Location> extractedStates = [];
      List<CarType> extractedVehicleTypes = [];
      List<CarFeature> extractedCarFeatures = [];
      List<CarColor> extractedCarColors = [];
      _models = [];

      // Brands and Models
      for (var element in responseData['brands']) {
        extractedCarModels = [];
        for (var ele in element['models_cars']) {
          extractedCarModels.add(
            CarModels(
              id: ele['id'],
              brandId: ele['brand_id'],
              name: ele['name'],
            ),
          );
        }
        _models = _models + extractedCarModels;
        extractedBrands.add(
          Brand(
              id: element['id'],
              name: element['name'],
              logo: Api.urlWithoutApi + element['logo'],
              models: extractedCarModels),
        );
      }
      _brands = extractedBrands;

      // states
      for (var element in responseData['states']) {
        extractedStates.add(
          Location(id: element['id'], name: element['name']),
        );
      }
      _states = extractedStates;

      // vehicle
      for (var element in responseData['vehicleTypes']) {
        extractedVehicleTypes.add(
          CarType(id: element['id'], name: element['name'], picture: ''),
        );
      }
      _carType = extractedVehicleTypes;

      // Car color
      for (var color in responseData['colors']) {
        extractedCarColors.add(CarColor(
            id: color['id'],
            value: '0xff${(color['value'].toString()).substring(1)}'));
      }
      _carColors = extractedCarColors;

      // Features
      for (var element in responseData['features']) {
        extractedCarFeatures.add(CarFeature(
            id: element['id'],
            name: element['type'],
            image: Api.urlWithoutApi + element['icon']));
      }
      _features = extractedCarFeatures;

      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  // Selected state
  void selectedStateFct(Location location) {
    _location = location.name;
    notifyListeners();
  }

  void clearStateFct() {
    _location = 'All states';
    notifyListeners();
  }

  void modelsByIdFct(int id) {
    List<CarModels> list = [];
    // list = _brands.map((e) => e.models).toList();
    print('models');
    print(_models);
    _modelsById = _models.where((element) => element.brandId == id).toList();

    print('models by id');
    print(modelsById);
    notifyListeners();
  }

  void filterPressedFct(bool filterPressed) {
    _isFilterPressed = filterPressed;
    notifyListeners();
  }
}
