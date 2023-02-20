import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/screens/car_detail/car_detail.dart';
import 'package:dream_access/screens/car_detail/car_detail_with_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/search_provider.dart';

class WantedCars extends StatelessWidget {
  const WantedCars({super.key});

  @override
  Widget build(BuildContext context) {
    var searchListenData = context.watch<SearchProvider>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: GeneralData.width),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: searchListenData.cars.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CarDetailWithId(carId: searchListenData.cars[index].id),
                ));
          },
          child: Container(
            padding: EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
            child: Text(
              searchListenData.cars[index].name.toString(),
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}
