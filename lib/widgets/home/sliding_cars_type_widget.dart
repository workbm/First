import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/models/car_type.dart';
import 'package:dream_access/screens/home/car_by_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/general_data.dart';

class SlidingCarsTypeWidget extends StatelessWidget {
  const SlidingCarsTypeWidget({super.key, required this.carsList});
  final List<CarType> carsList;
  @override
  Widget build(BuildContext context) {
    final carType = [
      'assets/images/Buggy.png',
      'assets/images/Classic.png',
      'assets/images/Commerciale.png',
      'assets/images/Convertible.png',
      'assets/images/Coupe.png',
      'assets/images/Grossover.png',
      'assets/images/Low-price.png',
      'assets/images/Luxe.png',
      'assets/images/MONTHLY.png',
      'assets/images/Speciale-Edition.png',
      'assets/images/Suv.png',
      'assets/images/With-Drtive.png',
      'assets/images/Yakhet.png',
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GeneralData.width,
      ),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: carsList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              print('carTypeId: ${carsList[index].id}');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarsByType(carId: carsList[index].id),
                  ));
            },
            child: Container(
                height: 84.h,
                width: 84.w,
                margin: EdgeInsets.only(right: 17.w),
                padding: EdgeInsets.all(18.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: carsList[index].picture,
                  fit: BoxFit.contain,
                  // height: height,
                  // width: width,
                )),
          ),
        ),
      ),
    );
  }
}
