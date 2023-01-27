import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/list_cars.dart';
import '../../models/car.dart';

class VectorsWidget extends StatelessWidget {
  const VectorsWidget({super.key, required this.car});
  final Car car;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: const Color(0xffD0D0D0),
              ),
            ),
            margin: EdgeInsets.only(right: 8.w),
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            child: Row(
              children: [
                Image.asset(
                  ListCars.vectorAssetList[index],
                  // vectorAssetList[index],
                ),
                SizedBox(width: 7.w),
                Text(
                  index == 0
                      ? car.type
                      : index == 1
                          ? car.doors.toString()
                          : index == 2
                              ? car.seat.toString()
                              : 'Cruise Control',
                  // vectorName[index],
                ),
              ],
            )),
      ),
    );
  }
}
