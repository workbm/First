import 'package:dream_access/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_bar_widget.dart';

class VerifiyPhone extends StatelessWidget {
  const VerifiyPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context) as AppBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bmBackground.png"),
                  fit: BoxFit.cover),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                  ),
                  Text(
                    'Verify',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 33.h),
                  const Text(
                    'Please enter the 4-digit code \nsent to your number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65.h,
                        width: 65.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 211, 211, 212),
                        ),
                      ),
                      Container(
                        height: 65.h,
                        width: 65.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 211, 211, 212),
                        ),
                      ),
                      Container(
                        height: 65.h,
                        width: 65.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 211, 211, 212),
                        ),
                      ),
                      Container(
                        height: 65.h,
                        width: 65.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 211, 211, 212),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r)),
                      fixedSize: Size(138.w, 48.h),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ),
                      );
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
