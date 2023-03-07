import 'package:dream_access/models/car_models.dart';

class Brand {
  int id;
  String name, logo;
  List<CarModels> models;
  Brand(
      {required this.id,
      required this.name,
      required this.logo,
      this.models = const []});
}
