import 'package:dream_access/providers/acceuil_provider.dart';
import 'package:dream_access/providers/agency_provider.dart';
import 'package:dream_access/providers/auth/login/login_phone_provider.dart';
import 'package:dream_access/providers/auth/login/login_provider.dart';
import 'package:dream_access/providers/auth/signup/email_verification_provider.dart';
import 'package:dream_access/providers/auth/signup/sign_up_phone_provider.dart';
import 'package:dream_access/providers/auth/signup/signup_provider.dart';
import 'package:dream_access/providers/car_by_id_provider.dart';
import 'package:dream_access/providers/cars_by_brand_provider.dart';
import 'package:dream_access/providers/filter_provider.dart';
import 'package:dream_access/providers/logout_provider.dart';
import 'package:dream_access/providers/pagination_provider.dart';
import 'package:dream_access/providers/password/send_mail_provider.dart';
import 'package:dream_access/providers/search_provider.dart';
import 'package:dream_access/providers/statistics_provider.dart';
import 'package:dream_access/providers/update_profile/update_image_provider.dart';
import 'package:dream_access/providers/update_profile/update_profile_provider.dart';
import 'package:dream_access/providers/wishlist/get_wishlist_provider.dart';
import 'package:dream_access/providers/wishlist/save_wishlist_provider.dart';
import 'package:dream_access/screens/auth/login/login/auth_screen.dart';
import 'package:dream_access/screens/home/home_page.dart';
import 'package:dream_access/screens/open/screen1.dart';
import 'package:dream_access/screens/profile/edit_profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/car_by_type_provider.dart';
import 'providers/new3_provider.dart';
import 'providers/search_by_filter_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AcceuilProvider>(
          create: (_) => AcceuilProvider(),
        ),
        ChangeNotifierProvider<AgencyProvider>(
          create: (_) => AgencyProvider(),
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
        ChangeNotifierProvider<EmailVerificationProvider>(
          create: (_) => EmailVerificationProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (_) => FilterProvider(),
        ),
        ChangeNotifierProvider<GetWishlistProvider>(
          create: (_) => GetWishlistProvider(),
        ),
        ChangeNotifierProvider<LoginPhoneProvider>(
          create: (_) => LoginPhoneProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider<LogoutProvider>(
          create: (_) => LogoutProvider(),
        ),
        ChangeNotifierProvider<New3Provider>(
          create: (_) => New3Provider(),
        ),
        ChangeNotifierProvider<PaginationProvider>(
          create: (_) => PaginationProvider(),
        ),
        ChangeNotifierProvider<SearchByFilterProvider>(
          create: (_) => SearchByFilterProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider<SendEmailProvider>(
          create: (_) => SendEmailProvider(),
        ),
        ChangeNotifierProvider<SignUpPhoneProvider>(
          create: (_) => SignUpPhoneProvider(),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (_) => SignUpProvider(),
        ),
        ChangeNotifierProvider<StatisticsProvider>(
          create: (_) => StatisticsProvider(),
        ),
        ChangeNotifierProvider<SaveWishlistProvider>(
          create: (_) => SaveWishlistProvider(),
        ),
        ChangeNotifierProvider<UpdateImageProvider>(
          create: (_) => UpdateImageProvider(),
        ),
        ChangeNotifierProvider<UpdateProfileProvider>(
          create: (_) => UpdateProfileProvider(),
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
            title: 'Drivers City',
            theme: theme,
            home: const Screen1(),
            builder: (context, child) => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: child,
            ),
            routes: {
              AuthScreen.routeName: (context) => const AuthScreen(),
              EditProfile.routeName: (context) => const EditProfile(),
              MyHomePage.routeName: (context) => const MyHomePage(),
            },
          );
        });
  }
}
