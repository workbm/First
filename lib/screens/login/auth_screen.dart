import 'package:dream_access/screens/home_page.dart';
import 'package:dream_access/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bmBackground.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 103.h,
                width: double.infinity,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 91.h,
                width: 85.w,
              ),
              SizedBox(
                height: 61.h,
              ),
              // Image.asset(
              //   'assets/images/Frame.png',
              //   height: 181.h,
              //   width: 310.w,
              // ),
              // SizedBox(
              //   height: 64.h,
              // ),
              Container(
                height: 60.h,
                width: 268.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 268.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Sign up',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120.h,
              ),
              // SizedBox(
              //   height: 350.h,
              //   width: double.infinity,
              //   child: Image.asset(
              //     'assets/images/generic-brandless-modern-sport-car-with-fire-smoke1.png',
              //     fit: BoxFit.cover,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
