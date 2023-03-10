import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/car.dart';
import '../../models/car_color.dart';

class GetWishlistProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => [..._cars];
  Future<void> getWishlistFct() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final url = Uri.parse(Api.url + Api.getWishlist);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      });
      var responseData = jsonDecode(response.body);

      List<Car> extractedCars = [];

      for (var ele in responseData) {
        List<CarColor> extractedExterCarColors = [];
        var carElement = ele['car'];
        if ((carElement['exter_colors'] as List).isNotEmpty) {
          for (var element in carElement['exter_colors']) {
            extractedExterCarColors.add(CarColor(
                id: element['id'],
                value: '0xff${(element['value'].toString()).substring(1)}'));
          }
        }
        List<CarColor> extractedInterCarColors = [];
        if ((carElement['inter_colors'] as List).isNotEmpty) {
          for (var element in carElement['inter_colors']) {
            extractedInterCarColors.add(CarColor(
                id: element['id'],
                value: '0xff${(element['value'].toString()).substring(1)}'));
          }
        }
        extractedCars.add(
          Car(
            id: carElement['id'],
            name: carElement['name'],
            agencyName: carElement['agency']['name'],
            agencyLogo: carElement['agency']['logo'],
            driverAge: carElement['driver_age'],
            engineCapacity:
                double.parse(carElement['engine_capacity'].toString()),
            exterColor: extractedExterCarColors,
            interColor: extractedInterCarColors,
            excessClaim: carElement['excess_claim'],
            extraMileageCost:
                double.parse(carElement['extra_milleage_cost'].toString()),
            image: [carElement['pictures'][0]['main_picture']],
            options: [
              'Minimum days: ${carElement['nbMinLocationPerDay']}',
              'Deposit: ${carElement['security_deposit']} AED',
              'Insurance included',
              'Free delivery',
            ],
            type: carElement['vahicle_type']['name'],
            priceByDay: carElement['pricePerDay'],
            priceByWeek: carElement['pricePerWeek'],
            priceByMonth: carElement['pricePerMonth'],
            bags: carElement['bags_capacity'] ?? 0,
            specsType: carElement['specsType'] ?? 0,
            transmissionType: carElement['transmissionType'] ?? 1,
          ),
        );
      }
      _cars = extractedCars;
      print('_cars.length');
      print(_cars.length);
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
