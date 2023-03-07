import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/car.dart';
import '../models/car_feature.dart';

class CarsByTypeProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => _cars;

  Future<void> carsByTypeFct(int id) async {
    _cars = [];
    var url = Uri.parse('${Api.url}${Api.carsByType}$id');
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);
      print('carsByTypeFct responseData:$responseData');
      List<Car> extractedCars = [];
      List<CarFeature> extractedCarFeatures = [];
      for (var element in responseData) {
        extractedCarFeatures = [];
        if (element['features'] != []) {
          for (var element2 in element['features']) {
            extractedCarFeatures.add(CarFeature(
                id: element2['id'],
                name: element2['type'],
                image: Api.urlWithoutApi + element2['icon']));
          }
        }
        List<String> extractedImages = [];
        for (var ele in element['pictures']) {
          if (ele['main_picture'] != null) {
            extractedImages.add(ele['main_picture']);
          }
          if (ele['child_picture'] != null) {
            extractedImages.add(ele['child_picture']);
          }
        }

        extractedCars.add(
          Car(
            id: element['id'],
            name: element['name'],
            agencyName: element['agency']['name'],
            agencyLogo: element['agency']['logo'],
            engineCapacity: double.parse(element['engine_capacity'].toString()),
            features: extractedCarFeatures,
            image: extractedImages,
            options: [
              'Minimum days: ${element['nbMinLocationPerDay']}',
              'Deposit: ${element['security_deposit']}',
              'Insurance included',
              'Free delivery',
            ],
            type: element['vahicle_type']['name'],
            priceByDay: element['pricePerDay'],
            priceByWeek: element['pricePerWeek'],
            priceByMonth: element['pricePerMonth'],
            bags: element['bags_capacity'] ?? 0,
            specsType: element['specsType'] ?? 0,
            transmissionType: element['transmissionType'] ?? 1,
          ),
        );
      }
      print('responseData');
      print(responseData);
      _cars = extractedCars;
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
    }
  }
}
