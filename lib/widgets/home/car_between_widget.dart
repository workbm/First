import 'package:dream_access/constants/general_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarBetweenWidget extends StatelessWidget {
  const CarBetweenWidget({super.key, required this.option});
  final int option;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 315.h,
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: GeneralData.width, vertical: 1.h),
      child: option == 1
          ? Stack(
              children: [
                SizedBox(
                  height: 150.h,
                  width: double.infinity,
                ),
                Positioned(
                  top: 4.h,
                  bottom: 4.h,
                  left: 1,
                  right: 1,
                  child: Image.asset(
                    'assets/images/maskGroup.png',
                    // fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 2.w,
                  child: Image.asset(
                    'assets/images/vector3.png',
                  ),
                ),
                Positioned(
                  top: 15.h,
                  left: 45.w,
                  child: Image.asset(
                    'assets/images/vector12.png',
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  left: 37.w,
                  child: Image.asset(
                    'assets/images/Vector5.png',
                  ),
                ),
              ],
            )
          : option == 2
              ? Stack(
                  children: [
                    SizedBox(
                      height: 150.h,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 4.h,
                      bottom: 4.h,
                      left: 1,
                      right: 1,
                      child: Image.asset(
                        'assets/images/image12.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 2.w,
                      child: Image.asset(
                        'assets/images/vector3.png',
                      ),
                    ),
                    Positioned(
                      top: 15.h,
                      right: 45.w,
                      child: Image.asset(
                        'assets/images/vector12.png',
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 26.w,
                      child: Image.asset(
                        'assets/images/Vector5.png',
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    SizedBox(
                      height: 150.h,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 4.h,
                      bottom: 4.h,
                      left: 1,
                      right: 1,
                      child: Image.asset(
                        'assets/images/image13.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 2.w,
                      child: Image.asset(
                        'assets/images/vector3.png',
                      ),
                    ),
                    Positioned(
                      top: 15.h,
                      left: 45.w,
                      child: Image.asset(
                        'assets/images/vector12.png',
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      left: 37.w,
                      child: Image.asset(
                        'assets/images/Vector5.png',
                      ),
                    ),
                  ],
                ),
    );
  }
}
