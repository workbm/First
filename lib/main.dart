import 'package:dream_access/screens/about_us.dart';
import 'package:dream_access/screens/home_page.dart';
import 'package:dream_access/screens/login/auth_screen.dart';
import 'package:dream_access/screens/login/login_screen.dart';
import 'package:dream_access/screens/open/screen1.dart';
import 'package:dream_access/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dream Access',
            theme: ThemeData(
              primaryColor: const Color(0xFFF00000),
              textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme.copyWith(
                      headline1: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                    ),
              ),
            ),
            home: const MyHomePage(),
          );
        });
  }
}
