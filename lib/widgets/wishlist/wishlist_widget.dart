import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/screens/car_detail/car_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/car.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({
    super.key,
    required this.cars,
    required this.option,
  });
  final List<Car> cars;
  final int option;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarDetail(car: cars[index]),
            ),
          );
        },
        child: Container(
          height: 153.h,
          width: 320.w,
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: GeneralData.borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2.h,
                ),
                height: 153.h,
                width: 125.w,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: cars[index].image[0],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 5.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: AutoSizeText(
                        cars[index].name,
                        style: Theme.of(context).textTheme.headline1,
                        wrapWords: false,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text(
                            'AED ',
                            maxLines: 1,
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                          Text(
                            cars[index].priceByDay.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 10),
                          ),
                          const Text(
                            '/day',
                            style: TextStyle(fontSize: 9),
                          ),
                          SizedBox(width: 5.w),
                          const Text(
                            'AED ',
                            maxLines: 1,
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                          Text(
                            cars[index].priceByWeek.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 10),
                          ),
                          const Text(
                            '/week',
                            style: TextStyle(fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      cars[index].agencyName,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
