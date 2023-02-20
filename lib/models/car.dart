import 'package:dream_access/models/car_color.dart';
import 'package:dream_access/models/car_feature.dart';

class Car {
  final int doors,
      id,
      driverAge,
      excessClaim,
      seat,
      priceByDay,
      priceByWeek,
      priceByMonth,
      bags,
      specsType,
      transmissionType;
  final double extraMileageCost, engineCapacity;
  final String name, description, agencyName, agencyLogo, type;
  final List<CarColor> exterColor;
  final List<CarColor> interColor;
  final List<CarFeature> features;
  final List<String> image;
  final List<String> options;
  Car({
    required this.id,
    required this.name,
    this.bags = 0,
    this.driverAge = 0,
    this.engineCapacity = 1.0,
    this.excessClaim = 0,
    this.exterColor = const [],
    this.extraMileageCost = 0,
    this.features = const [],
    this.interColor = const [],
    this.priceByDay = 0,
    this.priceByWeek = 0,
    this.priceByMonth = 0,
    required this.agencyName,
    this.agencyLogo = '',
    required this.image,
    required this.options,
    required this.type,
    this.doors = 4,
    this.seat = 4,
    this.description = '',
    this.specsType = 0,
    this.transmissionType = 1,
  });
}
