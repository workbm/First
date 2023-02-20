import 'package:dream_access/providers/acceuil_provider.dart';
import 'package:dream_access/providers/car_by_id_provider.dart';
import 'package:dream_access/providers/cars_by_brand_provider.dart';
import 'package:dream_access/providers/search_provider.dart';
import 'package:dream_access/screens/home/home_page.dart';
import 'package:dream_access/screens/new2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/car_by_type_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AcceuilProvider>(
          create: (_) => AcceuilProvider(),
        ),
        ChangeNotifierProvider<CarByIdProvider>(
          create: (_) => CarByIdProvider(),
        ),
        ChangeNotifierProvider<CarsByBrandProvider>(
          create: (_) => CarsByBrandProvider(),
        ),
        ChangeNotifierProvider<CarsByTypeProvider>(
          create: (_) => CarsByTypeProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      primaryColor: const Color(0xFFF00000),
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme.copyWith(
              headline1: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              headline2: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
              headline3: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red,
              ),
              bodyText2: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              headline4: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Color(0xFFF00000),
              ),
              headline5: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                // color: Color(0xFFF00000),
              ),
            ),
      ),
    );
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dream Access',
            theme: theme,
            home: const MyHomePage(),
            builder: (context, child) => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: child,
            ),
          );
        });
  }
}
