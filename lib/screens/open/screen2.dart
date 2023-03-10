import 'package:dream_access/screens/open/screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/slide_route.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/image2.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.height * 0.9,
            ),
            Positioned(
              bottom: 50.h,
              right: 5.w,
              child: Image.asset(
                'assets/images/Rectangle66.png',
                fit: BoxFit.fill,
                height: size.height * 0.065,
                width: size.width * 0.7,
              ),
            ),
            Positioned(
              bottom: 65.h,
              right: 53.w,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(page: const Screen3()),
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 65.h,
              right: 150.w,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 38.5.h,
              right: 185.w,
              child: Image.asset('assets/images/rectangle67.png'),
            ),
            // Positioned(
            //   bottom: 10.h,
            //   right: 5.w,
            //   child: Image.asset('assets/images/Rectangle66.png'),
            // ),
            // Positioned(
            //   bottom: 25.h,
            //   right: 95.w,
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => Screen3(),
            //           ));
            //     },
            //     child: Text(
            //       'Next',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 25),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
