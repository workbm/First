import 'dart:convert';

import 'package:dream_access/models/agency/agency.dart';
import 'package:dream_access/models/agency/work_day.dart';
import 'package:dream_access/models/car.dart';
import 'package:dream_access/models/car_feature.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../constants/api.dart';
import '../models/car_color.dart';

class AgencyProvider with ChangeNotifier {
  List<Agency> _agency = [];
  List<Agency> get agency => _agency;
  bool _buttonClicked = false;
  bool get buttonClicked => _buttonClicked;

  Future<void> agencyFct(int agencyID) async {
    final url = Uri.parse('${Api.url}${Api.agency}$agencyID');
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);

      List<Agency> extractedAgencies = [];
      List<Car> extractedCars = [];
      // cars
      extractedCars = [];
      if (responseData['cars'] != []) {
        for (var element in responseData['cars']) {
          // features
          List<CarFeature> extractedCarFeature = [];
          if (element['features'] != []) {
            for (var element2 in element['features']) {
              extractedCarFeature.add(CarFeature(
                  id: element2['id'],
                  name: element2['type'],
                  image: Api.urlWithoutApi + element2['icon']));
            }
          }
          // exte colors
          List<CarColor> extractedExterCarColors = [];
          if (element['exter_colors'] != null &&
              (element['exter_colors'] as List).isNotEmpty) {
            for (var color in element['exter_colors']) {
              extractedExterCarColors.add(CarColor(
                  id: color['id'],
                  value: '0xff${(color['value'].toString()).substring(1)}'));
            }
          }
          // inte colors
          List<CarColor> extractedInterCarColors = [];
          if (element['inter_colors'] != null &&
              (element['inter_colors'] as List).isNotEmpty) {
            for (var color in element['inter_colors']) {
              extractedInterCarColors.add(CarColor(
                  id: color['id'],
                  value:
                      '0xff${((color['value'] ?? '#ffffff').toString()).substring(1)}'));
            }
          }
          // Images
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
              driverAge: element['driver_age'] ?? 20,
              engineCapacity:
                  double.parse((element['engine_capacity'] ?? 0).toString()),
              exterColor: extractedExterCarColors,
              interColor: extractedInterCarColors,
              features: extractedCarFeature,
              image: extractedImages,
              // [element['pictures'][0]['main_picture']],
              options: [
                'Minimum days: ${element['nbMinLocationPerDay'] ?? 0}',
                'Deposit: ${element['security_deposit'] ?? 0}',
                'Insurance included',
                'Free delivery',
              ],
              type: element['vahicle_type']['name'],
              priceByDay: element['pricePerDay'] ?? 0,
              priceByWeek: element['pricePerWeek'] ?? 0,
              priceByMonth: element['pricePerMonth'] ?? 0,
              bags: element['bags_capacity'] ?? 0,
              specsType: element['specsType'] ?? 0,
              transmissionType: element['transmissionType'] ?? 1,
            ),
          );
        }
      }
      // Work days
      List<WorkDay> extractedWorkDay = [];
      for (var element in responseData['dayswork']) {
        extractedWorkDay.add(
          WorkDay(
              id: element['id'],
              agencyID: element['agency_id'],
              name: element['day'],
              start: element['start'] ?? '',
              end: element['end'] ?? '',
              openAllDay: element['is_full_day'],
              closedAllDay: element['is_closed']),
        );
      }

      extractedAgencies.add(
        Agency(
          id: responseData['id'],
          name: responseData['name'],
          logo: responseData['logo'],
          phone: responseData['phone'],
          cars: extractedCars,
          workDays: extractedWorkDay,
          address: responseData['address'],
          country: responseData['country'],
          wtspPhone: responseData['wtsp_phone'],
          descritpion: responseData['description'] ?? '',
          isVerified: responseData['is_verified'],
          y: responseData['y'],
          x: responseData['x'],
        ),
      );

      _agency = extractedAgencies;
      print(responseData['id']);
      print('agency: ${responseData['y']}, ${responseData['x']}');
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  void buttonClickedFct(bool isClicked) {
    print('buttonClickedFct');
    _buttonClicked = isClicked;
    notifyListeners();
  }
}
