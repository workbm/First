import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/screens/profile/about_us.dart';
import 'package:dream_access/screens/profile/privacy.dart';
import 'package:dream_access/screens/profile/terms_use.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'terms_conditions.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            size: 30.r,
            color: Colors.black,
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: GeneralData.width3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Image.asset('assets/images/LogoDriversCityNoirEtRouge.png',
                  fit: BoxFit.contain, height: 100.h, width: 200.w),
              // ListTile(
              //   contentPadding: const EdgeInsets.all(0),
              //   leading: Container(
              //     height: 65.h,
              //     width: 65.w,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       border: Border.all(),
              //     ),
              //     child: const Icon(
              //       Icons.person,
              //       color: Colors.red,
              //     ),
              //   ),
              //   title: const Text(
              //     'Karim Bennis',
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //   ),
              //   subtitle: const Text('+971  4 224 5555'),
              // ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('About us'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUs(),
                      ));
                },
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Terms of use'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsOfUse(),
                      ));
                },
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Privacy Policy'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Privacy(),
                      ));
                },
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Terms & Conditions'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsConditions(),
                      ));
                },
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              // const ListTile(
              //   contentPadding: EdgeInsets.all(0),
              //   title: Text('Logout'),
              //   trailing: Icon(
              //     Icons.navigate_next,
              //     color: Colors.red,
              //   ),
              // ),
              // const Divider(
              //   indent: 0,
              //   endIndent: 0,
              //   color: Colors.black,
              //   thickness: 0.5,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
