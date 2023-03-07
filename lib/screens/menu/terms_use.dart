import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/general_data.dart';
import '../../providers/acceuil_provider.dart';
import '../../widgets/home/best_offers_widget.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});
  @override
  Widget build(BuildContext context) {
    void openWhatsApp() async {
      await canLaunch(
              'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
          ? await launch(
              'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
          : throw 'Could not launch WhatsApp';
    }

    var data = context.watch<AcceuilProvider>();

    return Scaffold(
      // appBar: AppBar(title: Image.asset('assets/images/logo.png',)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GeneralData.width2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stack(
                    //   children: [
                    //     SizedBox(
                    //       width: double.infinity,
                    //       height: 299.h,
                    //     ),
                    //     SizedBox(
                    //       width: double.infinity,
                    //       height: 250.h,
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.only(
                    //           bottomLeft: Radius.circular(10.r),
                    //           bottomRight: Radius.circular(10.r),
                    //         ),
                    //         child: CachedNetworkImage(
                    //           imageUrl:
                    //               'https://wallpapercave.com/wp/wp7728785.jpg',
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       bottom: 0,
                    //       right: 39.r,
                    //       left: 39.r,
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           InkWell(
                    //             onTap: () async {
                    //               final Uri launchUri = Uri(
                    //                 scheme: 'tel',
                    //                 path: '+1-555-010-999',
                    //               );
                    //               await launchUrl(launchUri);
                    //             },
                    //             child: CircleAvatar(
                    //               radius: 36.r,
                    //               backgroundColor:
                    //                   Theme.of(context).primaryColor,
                    //               child:
                    //                   Image.asset('assets/images/appel1.png'),
                    //             ),
                    //           ),
                    //           InkWell(
                    //             onTap: () {
                    //               openWhatsApp();
                    //             },
                    //             child: CircleAvatar(
                    //               radius: 36.r,
                    //               backgroundColor: const Color(0xff8BC442),
                    //               child:
                    //                   Image.asset('assets/images/watssap.png'),
                    //             ),
                    //           ),
                    //           CircleAvatar(
                    //             radius: 36.r,
                    //             backgroundColor: Colors.black,
                    //             child: Image.asset('assets/images/mail1.png'),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     IconButton(
                    //       padding: const EdgeInsets.all(10),
                    //       onPressed: () {
                    //         Navigator.of(context).pop();
                    //       },
                    //       icon: const Icon(
                    //         Icons.arrow_back_ios,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Image.asset(
                    //       'assets/images/logo.png',
                    //       height: 60.h,
                    //       width: 60.w,
                    //     )
                    //   ],
                    // ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text(
                          'Terms of use:',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Introduction:',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'These terms of use (the "Terms of Use") govern your use of Drivers City (the "Drivers City.com"), an online platform for [provide a brief description of the website]. The Website is operated by [Name of Website] (the "Company"). By accessing and using the Website, you agree to be bound by these Terms of Use, which constitute a legally binding agreement between you and the Company. If you do not agree to these Terms of Use, you may not access or use the Website. The Company reserves the right, at its sole discretion, to modify these Terms of Use at any time, and you are responsible for regularly reviewing the most current version available on the Website. Your continued use of the Website after any changes have been made constitutes your acceptance of the new Terms of Use.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'User Account and Responsibilities:',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          '1.1 User Account:',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'In order to use certain features of the Website, you may need to create an account. When creating an account, you must provide accurate and complete information about yourself as prompted by the registration form, and you must maintain and update this information to keep it current. You are responsible for maintaining the confidentiality of your account and password, and for restricting access to your computer. You agree to accept responsibility for all activities that occur under your account or password, including but not limited to all transactions made through the Website.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      '1.2 User Conduct:',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'You agree to use the Website only for lawful purposes, and in a manner that does not infringe the rights of, or restrict or inhibit the use and enjoyment of the Website by any third party. Prohibited conduct includes, but is not limited to:',
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {},
                            child: const Text('Read more'))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 38.h),
              BestOffersWidget(
                title: 'Our best offers',
                option: 1,
                car: data.latestBestOffers,
              )
            ],
          ),
        ),
      ),
    );
  }
}
