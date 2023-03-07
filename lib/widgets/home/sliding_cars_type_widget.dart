import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/models/car_type.dart';
import 'package:dream_access/screens/home/car_by_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/general_data.dart';
import '../helpers/gap_widget.dart';

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
        height: 120.h,
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
            child: Column(
              children: [
                Container(
                    height: 84.h,
                    width: 105.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(
                        //   color: const Color.fromARGB(230, 248, 244, 244),
                        // ),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 0.1,
                              spreadRadius: 1,
                              color: Color.fromARGB(255, 221, 221, 221)),
                        ]),
                    child: CachedNetworkImage(
                      imageUrl: carsList[index].picture,
                      fit: BoxFit.contain,
                    )),
                const Gap(height: 7),
                Container(
                  // height: 84.h,
                  width: 105.w,
                  margin: EdgeInsets.only(right: 10.w),
                  // padding: EdgeInsets.all(11.r),
                  child: Center(
                    child: Text(
                      carsList[index].name.length <= 8
                          ? carsList[index].name
                          : '${carsList[index].name.substring(0, 8)}..',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
