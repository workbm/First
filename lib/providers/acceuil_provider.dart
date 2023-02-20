import 'dart:convert';

import 'package:dream_access/constants/api.dart';
import 'package:dream_access/models/brand.dart';
import 'package:dream_access/models/car.dart';
import 'package:dream_access/models/car_feature.dart';
import 'package:dream_access/models/car_type.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/car_color.dart';

class AcceuilProvider with ChangeNotifier {
  List<Brand> _topBrands = [];
  List<Brand> get topBrands => [..._topBrands];
  List<CarType> _carType = [];
  List<CarType> get carType => [..._carType];
  List<Car> _latestBestOffers = [];
  List<Car> get latestBestOffers => [..._latestBestOffers];
  List<Car> _luxuryCars = [];
  List<Car> get luxuryCars => [..._luxuryCars];
  List<Car> _suvCars = [];
  List<Car> get suvCars => [..._suvCars];
  List<Car> _cars = [];
  List<Car> get cars => [..._cars];
  Future<void> acceuilFct() async {
    var url = Uri.parse(Api.url + Api.acceuil);
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);
      List<Brand> extractedBrands = [];
      List<CarType> extractedVehicleTypes = [];

      for (var element in responseData['brands']) {
        extractedBrands.add(Brand(
            id: element['id'],
            name: element['name'],
            logo: Api.urlWithoutApi + element['logo']));
      }
      _topBrands = extractedBrands;

      for (var element in responseData['vehicleTypes']) {
        extractedVehicleTypes.add(
          CarType(
              id: element['id'],
              name: element['name'],
              picture: Api.urlWithoutApi + element['picture']),
        );
      }
      _carType = extractedVehicleTypes;
//Latest best offers
      List<Car> extratedBestOffers = [];
      List<CarFeature> extractedCarFeatureBestOffers = [];
      for (var element in responseData['latestBestOffers']) {
        extractedCarFeatureBestOffers = [];
        if (element['features'] != []) {
          for (var element2 in element['features']) {
            extractedCarFeatureBestOffers.add(CarFeature(
                id: element2['id'],
                name: element2['type'],
                image: Api.urlWithoutApi + element2['icon']));
          }
        }

        List<CarColor> extractedExterCarColors = [];
        if ((element['exter_colors'] as List).isNotEmpty) {
          for (var color in element['exter_colors']) {
            extractedExterCarColors.add(CarColor(
                id: color['id'],
                value: '0xff${(color['value'].toString()).substring(1)}'));
          }
        }
        List<CarColor> extractedInterCarColors = [];
        if ((element['inter_colors'] as List).isNotEmpty) {
          for (var color in element['inter_colors']) {
            extractedInterCarColors.add(CarColor(
                id: color['id'],
                value: '0xff${(color['value'].toString()).substring(1)}'));
          }
        }
        extratedBestOffers.add(
          Car(
            id: element['id'],
            name: element['name'],
            agencyName: element['agency']['name'],
            agencyLogo: element['agency']['logo'],
            driverAge: element['driver_age'],
            engineCapacity: double.parse(element['engine_capacity'].toString()),
            exterColor: extractedExterCarColors,
            interColor: extractedInterCarColors,
            features: extractedCarFeatureBestOffers,
            image: [element['pictures'][0]['main_picture']],
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
      _latestBestOffers = extratedBestOffers;
// Luxury cars
      List<Car> extractedLuxury = [];
      List<CarFeature> extractedCarFeatureLuxury = [];
      for (var element in responseData['luxuryCars']) {
        extractedCarFeatureLuxury = [];
        if (element['features'] != []) {
          for (var element2 in element['features']) {
            extractedCarFeatureLuxury.add(CarFeature(
                id: element2['id'],
                name: element2['type'],
                image: Api.urlWithoutApi + element2['icon']));
          }
        }

        List<CarColor> extractedExterCarColors = [];
        if ((element['exter_colors'] as List).isNotEmpty) {
          for (var color in element['exter_colors']) {
            extractedExterCarColors.add(CarColor(
                id: color['id'],
                value: '0xff${(color['value'].toString()).substring(1)}'));
          }
        }
        List<CarColor> extractedInterCarColors = [];
        if ((element['inter_colors'] as List).isNotEmpty) {
          for (var color in element['inter_colors']) {
            extractedInterCarColors.add(CarColor(
                id: color['id'],
                value: '0xff${(color['value'].toString()).substring(1)}'));
          }
        }
        extractedLuxury.add(
          Car(
            id: element['id'],
            name: element['name'],
            agencyName: element['agency']['name'],
            agencyLogo: element['agency']['logo'],
            driverAge: element['driver_age'],
            engineCapacity: double.parse(element['engine_capacity'].toString()),
            exterColor: extractedExterCarColors,
            interColor: extractedInterCarColors,
            extraMileageCost: element['extra_milleage_cost'],
            features: extractedCarFeatureLuxury,
            image: [element['pictures'][0]['main_picture']],
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
      _luxuryCars = extractedLuxury;
// Suv cars
      List<Car> extractedSuv = [];
      List<CarFeature> extractedCarFeatureSuv = [];
      for (var element in responseData['suvCars']) {
        extractedCarFeatureSuv = [];
        if (element['features'] != []) {
          for (var element2 in element['features']) {
            extractedCarFeatureSuv.add(CarFeature(
                id: element2['id'],
                name: element2['type'],
                image: Api.urlWithoutApi + element2['icon']));
          }
        }

        List<CarColor> extractedExterCarColors = [];
        if ((element['exter_colors'] as List).isNotEmpty) {
          for (var color in element['exter_colors']) {
            extractedExterCarColors.add(CarColor(
                id: color['id'],
                value: '0xff${(color['value'].toString()).substring(1)}'));
          }
        }
        List<CarColor> extractedInterCarColors = [];
        if ((element['inter_colors'] as List).isNotEmpty) {
          for (var color in element['inter_colors']) {
            extractedInterCarColors.add(CarColor(
                id: color['id'],
                value: '0xff${(color['value'].toString()).substring(1)}'));
          }
        }
        extractedSuv.add(
          Car(
            id: element['id'],
            name: element['name'],
            agencyName: element['agency']['name'],
            agencyLogo: element['agency']['logo'],
            driverAge: element['driver_age'],
            engineCapacity: double.parse(element['engine_capacity'].toString()),
            exterColor: extractedExterCarColors,
            interColor: extractedInterCarColors,
            extraMileageCost: element['extra_milleage_cost'],
            features: extractedCarFeatureSuv,
            image: [element['pictures'][0]['main_picture']],
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
      _suvCars = extractedSuv;

      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  Future<void> paginationFct(int page) async {
    var url = Uri.parse('${Api.url}${Api.pagination}$page');
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);
      List<Car> extractedCars = [];

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
      notifyListeners();
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }
}
