import 'package:dream_access/models/agency/work_day.dart';
import 'package:dream_access/models/car.dart';

class Agency {
  int id, isVerified;
  String address, country, name, phone, logo, descritpion, wtspPhone;
  List<Car> cars;
  List<WorkDay> workDays;
  Agency(
      {required this.id,
      required this.name,
      required this.logo,
      required this.phone,
      required this.cars,
      required this.address,
      required this.wtspPhone,
      required this.country,
      required this.workDays,
      this.isVerified = 1,
      this.descritpion = ''});
}
