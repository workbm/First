import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryContainerWidget extends StatelessWidget {
  const DeliveryContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15.r)),
      padding: EdgeInsets.fromLTRB(8.w, 15.w, 8.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              'Delivery & pick up service',
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset('assets/images/carDetail1.png'),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 100.w,
                    height: 50.h,
                    child: const AutoSizeText(
                      'Branch Pick-\nup',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/images/carDetail2.png'),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 100.w,
                    height: 50.h,
                    child: const AutoSizeText(
                      'Delivery to\nYou',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/images/map-marker-home.png'),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 100.w,
                    height: 50.h,
                    child: const AutoSizeText(
                      'Airport\nDelivery',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
