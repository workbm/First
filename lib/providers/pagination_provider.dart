import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/car.dart';
import '../models/car_color.dart';

class PaginationProvider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => [..._cars];
  int _lastPage = 1;
  int get lastPage => _lastPage;
  Future<void> searchByKeywordFct(int page, String keyword) async {
    var url = Uri.parse('${Api.url}${Api.pagination}$page');
    print('keyword');
    print(keyword);
    try {
      var response = await http.post(url,
          body: jsonEncode({'keyword': keyword}),
          headers: {'Content-Type': 'application/json'});
      var responseData = json.decode(response.body);
      print('responseDta');
      print(responseData);
      List<Car> extractedCars = [];
      _lastPage = responseData['allCars']['last_page'];

      for (var ele in responseData['allCars']['data']) {
        List<CarColor> extractedExterCarColors = [];
        if ((ele['exter_colors'] as List).isNotEmpty) {
          for (var element in ele['exter_colors']) {
            extractedExterCarColors.add(CarColor(
                id: element['id'],
                value: '0xff${(element['value'].toString()).substring(1)}'));
          }
        }
        List<CarColor> extractedInterCarColors = [];
        if ((ele['inter_colors'] as List).isNotEmpty) {
          for (var element in ele['inter_colors']) {
            extractedInterCarColors.add(CarColor(
                id: element['id'],
                value: '0xff${(element['value'].toString()).substring(1)}'));
          }
        }
        extractedCars.add(
          Car(
            id: ele['id'],
            name: ele['name'],
            agencyName: ele['agency']['name'],
            agencyLogo: ele['agency']['logo'],
            driverAge: ele['driver_age'],
            engineCapacity: double.parse(ele['engine_capacity'].toString()),
            exterColor: extractedExterCarColors,
            interColor: extractedInterCarColors,
            excessClaim: ele['excess_claim'],
            extraMileageCost:
                double.parse(ele['extra_milleage_cost'].toString()),
            image: [ele['pictures'][0]['main_picture']],
            options: [
              'Minimum days: ${ele['nbMinLocationPerDay']}',
              'Deposit: ${ele['security_deposit']} AED',
              'Insurance included',
              'Free delivery',
            ],
            type: ele['vahicle_type']['name'],
            priceByDay: ele['pricePerDay'],
            priceByWeek: ele['pricePerWeek'],
            priceByMonth: ele['pricePerMonth'],
            bags: ele['bags_capacity'] ?? 0,
            specsType: ele['specsType'] ?? 0,
            transmissionType: ele['transmissionType'] ?? 1,
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
