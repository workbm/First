import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api.dart';
import '../models/agency/agency.dart';
import '../models/car.dart';
import '../models/car_color.dart';

class New3Provider with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars => [..._cars];
  int _lastPage = 1;
  int get lastPage => _lastPage;
  Future<void> paginationFct(int page) async {
    var url = Uri.parse('${Api.url}${Api.pagination}$page');
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);

      _lastPage = responseData['allCars']['last_page'];
      List<Car> extractedCars = [];
      for (var ele in responseData['allCars']['data']) {
        List<CarColor> extractedExterCarColors = [];
        if (ele['exter_colors'] != null &&
            (ele['exter_colors'] as List).isNotEmpty) {
          for (var element in ele['exter_colors']) {
            extractedExterCarColors.add(CarColor(
                id: element['id'],
                value:
                    '0xff${((element['value'] ?? '#ffffff').toString()).substring(1)}'));
          }
        }
        List<CarColor> extractedInterCarColors = [];
        if (ele['inter_colors'] != null &&
            (ele['inter_colors'] as List).isNotEmpty) {
          for (var element in ele['inter_colors']) {
            extractedInterCarColors.add(CarColor(
                id: element['id'],
                value:
                    '0xff${((element['value'] ?? '#ffffff').toString()).substring(1)}'));
          }
        }
        List<String> extractedImages = [];
        for (var elee in ele['pictures']) {
          if (elee['main_picture'] != null) {
            extractedImages.add(elee['main_picture']);
          }
          if (elee['child_picture'] != null) {
            extractedImages.add(elee['child_picture']);
          }
        }

        extractedCars.add(
          Car(
            id: ele['id'],
            name: ele['name'],
            agencyName: ele['agency']['name'],
            agencyLogo: ele['agency']['logo'],
            agence: [
              Agency(
                id: ele['agency']['id'],
                name: ele['agency']['name'],
                logo: ele['agency']['logo'] ?? '',
                phone: ele['agency']['phone'] ?? '',
                cars: extractedCars,
                workDays: [],
                address: ele['agency']['address'] ?? '',
                country: ele['agency']['country'] ?? '',
                wtspPhone: ele['agency']['wtsp_phone'] ?? '',
                descritpion: ele['agency']['description'] ?? '',
                isVerified: ele['agency']['is_verified'],
                y: ele['agency']['y'] ?? 0,
                x: ele['agency']['x'] ?? 0,
              )
            ],
            driverAge: ele['driver_age'],
            engineCapacity: 1.0,
            // double.parse(ele['engine_capacity'].toString()),
            exterColor: extractedExterCarColors,
            interColor: extractedInterCarColors,
            excessClaim: ele['excess_claim'],
            extraMileageCost:
                double.parse((ele['extra_milleage_cost'] ?? 0).toString()),
            image: extractedImages,
            kmPerDay: ele['kilometragePerDay'] ?? 0,
            kmPerMonth: ele['kilometragePerMonth'] ?? 0,
            kmPerWeek: ele['kilometragePerWeek'] ?? 0,
            options: [
              'Minimum days: ${(ele['nbMinLocationPerDay'] ?? 0)}',
              'Deposit: ${(ele['security_deposit'] ?? 0)} AED',
              'Insurance included',
              'Free delivery',
            ],
            type: ele['vahicle_type']['name'] ?? '',
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
