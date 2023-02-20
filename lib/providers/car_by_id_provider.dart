import 'dart:convert';

import 'package:dream_access/models/car_color.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/car.dart';
import '../models/car_feature.dart';

class CarByIdProvider with ChangeNotifier {
  Car _car =
      Car(id: 0, name: '', agencyName: '', image: [], options: [], type: '');
  Car get car => _car;

  Future carByIdProviderFct(int carId) async {
    var url = Uri.parse(
        'https://driverscity.client-excelenciatech.shop/api/car/$carId/show');
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);
      List<CarFeature> extractedCarFeature = [];
      if (responseData['features'] != []) {
        for (var element in responseData['features']) {
          extractedCarFeature.add(CarFeature(
              id: element['id'],
              name: element['type'],
              image: Api.urlWithoutApi + element['icon']));
        }
      }

      List<String> extractedCarImages = [];
      for (var element in responseData['pictures']) {
        if (element['main_picture'] != null) {
          extractedCarImages.add(element['main_picture']);
        }
      }

      List<CarColor> extractedInterCarColors = [];
      if (responseData['inter_colors'] != []) {
        for (var element in responseData['inter_colors']) {
          extractedInterCarColors.add(CarColor(
              id: element['id'],
              value: '0xff${(element['value'].toString()).substring(1)}'));
        }
      }
      List<CarColor> extractedExterCarColors = [];
      if (responseData['exter_colors'] != []) {
        for (var element in responseData['exter_colors']) {
          extractedExterCarColors.add(CarColor(
              id: element['id'],
              value: '0xff${(element['value'].toString()).substring(1)}'));
        }
      }
      _car = Car(
        id: responseData['id'],
        name: responseData['name'],
        agencyName: responseData['agency']['name'],
        agencyLogo: responseData['agency']['logo'],
        exterColor: extractedExterCarColors,
        interColor: extractedInterCarColors,
        engineCapacity:
            double.parse(responseData['engine_capacity'].toString()),
        features: extractedCarFeature,
        image: extractedCarImages,
        options: [
          'Minimum days: ${responseData['nbMinLocationPerDay']}',
          'Deposit: ${responseData['security_deposit']}',
          'Insurance included',
          'Free delivery',
        ],
        type: responseData['vahicle_type']['name'],
        priceByDay: responseData['pricePerDay'],
        priceByWeek: responseData['pricePerWeek'],
        priceByMonth: responseData['pricePerMonth'],
        bags: responseData['bags_capacity'] ?? 0,
        specsType: responseData['specsType'] ?? 0,
        transmissionType: responseData['transmissionType'] ?? 1,
      );

      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
