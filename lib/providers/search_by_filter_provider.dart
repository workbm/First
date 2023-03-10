import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/car.dart';
import '../models/car_color.dart';

class SearchByFilterProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => [..._cars];
  bool _isDeleteFunctionGetPressed = false;
  bool get isDeleteFunctionGetPressed => _isDeleteFunctionGetPressed;

  bool _selectBrand = false;
  bool get selectBrand => _selectBrand;
  bool _modelYear = false;
  bool get modelYear => _modelYear;
  bool _selectSeats = false;
  bool get selectSeats => _selectSeats;
  bool _selectVehicleType = false;
  bool get selectVehicleType => _selectVehicleType;
  bool _minimumAge = false;
  bool get minimumAge => _minimumAge;
  bool _rentalPeriod = false;
  bool get rentalPeriod => _rentalPeriod;
  bool _carFeature = false;
  bool get carFeature => _carFeature;
  bool _carColor = false;
  bool get carColor => _carColor;

  Map<String, dynamic> _map = {
    "state": null,
    "carmake": null,
    "modelCar": null,
    "year": null,
    "pass": null,
    "group": null,
    "min_required_age": null,
    "fea": null,
    "day_budget": null,
    "month_budget": null,
    "min_days_booking": null,
    "transmission": null,
    "clr": null,
    "order": null
  };
  Map<String, dynamic> get map => _map;
  Future<void> searchByFilterFct(int page) async {
    var url = Uri.parse('${Api.url}${Api.pagination}');
    print('map in future');
    print(_map);
    try {
      var response = await http.post(url,
          body: jsonEncode(_map),
          headers: {'Content-Type': 'application/json'});
      var responseData = json.decode(response.body);
      print('responseDta');
      print(responseData);
      List<Car> extractedCars = [];

      for (var ele in responseData['allCars']['data']) {
        List<CarColor> extractedExterCarColors = [];
        if (ele['exter_colors'] != null &&
            (ele['exter_colors'] as List).isNotEmpty) {
          for (var element in ele['exter_colors']) {
            extractedExterCarColors.add(CarColor(
                id: element['id'],
                value:
                    '0xff${(element['value'] ?? '#ffffff'.toString()).substring(1)}'));
          }
        }
        List<CarColor> extractedInterCarColors = [];
        if (ele['inter_colors'] != null &&
            (ele['inter_colors'] as List).isNotEmpty) {
          for (var element in ele['inter_colors']) {
            extractedInterCarColors.add(CarColor(
                id: element['id'],
                value:
                    '0xff${(element['value'] ?? '#ffffff'.toString()).substring(1)}'));
          }
        }
        extractedCars.add(
          Car(
            id: ele['id'],
            name: ele['name'],
            agencyName: ele['agency']['name'],
            agencyLogo: ele['agency']['logo'],
            driverAge: ele['driver_age'] ?? 0,
            engineCapacity:
                double.parse((ele['engine_capacity'] ?? 0).toString()),
            exterColor: extractedExterCarColors,
            interColor: extractedInterCarColors,
            excessClaim: ele['excess_claim'] ?? 0,
            extraMileageCost:
                double.parse((ele['extra_milleage_cost'] ?? 0).toString()),
            image: [ele['pictures'][0]['main_picture'] ?? ''],
            options: [
              'Minimum days: ${ele['nbMinLocationPerDay'] ?? 0}',
              'Deposit: ${ele['security_deposit'] ?? 0} AED',
              'Insurance included',
              'Free delivery',
            ],
            type: ele['vahicle_type']['name'],
            priceByDay: ele['pricePerDay'] ?? 0,
            priceByWeek: ele['pricePerWeek'] ?? 0,
            priceByMonth: ele['pricePerMonth'] ?? 0,
            bags: ele['bags_capacity'] ?? 0,
            specsType: ele['specsType'] ?? 0,
            transmissionType: ele['transmissionType'] ?? 1,
          ),
        );
      }
      _cars = extractedCars;
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  void selectBrandFct() {
    _selectBrand = true;
    notifyListeners();
  }

  void selectVehicleTypeFct() {
    _selectVehicleType = true;
    notifyListeners();
  }

  void selectModelYearFct() {
    _modelYear = true;
    notifyListeners();
  }

  void selectSeatsFct() {
    _selectSeats = true;
    notifyListeners();
  }

  void selectminimumAgeFct() {
    _minimumAge = true;
    notifyListeners();
  }

  void selectRentalPeriodFct() {
    _rentalPeriod = true;
    notifyListeners();
  }

  void selectCarFeatureFct() {
    _carFeature = true;
    notifyListeners();
  }

  void selectCarColorFct() {
    _carColor = true;
    notifyListeners();
  }

  void clearFct() {
    _map = {
      "state": null,
      "carmake": null,
      "modelCar": null,
      "year": null,
      "pass": null,
      "group": null,
      "min_required_age": null,
      "fea": null,
      "day_budget": null,
      "month_budget": null,
      "min_days_booking": null,
      "transmission": null,
      "clr": null,
      "order": null
    };
    _selectBrand = _modelYear = _selectSeats = false;
    _selectVehicleType = false;
    _minimumAge = false;
    _rentalPeriod = _carFeature = _carColor = false;
    _isDeleteFunctionGetPressed = true;
    notifyListeners();
  }

  void mapFct(String key, dynamic newValue) {
    _map.update(key, (value) => newValue);
    print('map:');
    print(map);
    notifyListeners();
  }
}


// 'state': null, //state_id
    // 'carmake': null, //brand_id
    // 'modelCar': null, //model_car_id
    // 'year': null, //moldel_year
    // 'pass': null, //nb_seats
    // 'group': null, //vehicles_ids
    // 'fea': null, //features_ids
    // 'day_budget': null, //price per day max limit
    // 'month_budget': null, //price per month max limit
    // 'min_days_booking': null, //nbMinLocationPerDay
    // 'transmission': null, //transmission type
    // 'clr': null, //colors_id
    // 'order': null //her it can be an integer 2 or 3 or 4 or 5
    // // 2 = orderBy pricePerDay from low to high
    // // 3 = orderBy pricePerDay from hight to low
    // // 4 = orderBy pricePerWeek from low to high
    // // 5 = orderBy pricePerMonth from low to high