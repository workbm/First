import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/providers/acceuil_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../constants/list_cars.dart';
import '../../widgets/home/best_offers_widget.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    // void openWhatsApp() async {
    //   await canLaunch(
    //           'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
    //       ? await launch(
    //           'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
    //       : throw 'Could not launch WhatsApp';
    // }
    var data = context.watch<AcceuilProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GeneralData.width2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 359.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 359.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://driverscity.client-excelenciatech.shop/application/views/images/aboutus.png',
                              // 'https://wallpapercave.com/wp/wp7728785.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Positioned(
                        //   bottom: 0,
                        //   right: 39.r,
                        //   left: 39.r,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       InkWell(
                        //         onTap: () async {
                        //           final Uri launchUri = Uri(
                        //             scheme: 'tel',
                        //             path: '+1-555-010-999',
                        //           );
                        //           await launchUrl(launchUri);
                        //         },
                        //         child: CircleAvatar(
                        //           radius: 36.r,
                        //           backgroundColor:
                        //               Theme.of(context).primaryColor,
                        //           child:
                        //               Image.asset('assets/images/appel1.png'),
                        //         ),
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           openWhatsApp();
                        //         },
                        //         child: CircleAvatar(
                        //           radius: 36.r,
                        //           backgroundColor: const Color(0xff8BC442),
                        //           child:
                        //               Image.asset('assets/images/watssap.png'),
                        //         ),
                        //       ),
                        //       CircleAvatar(
                        //         radius: 36.r,
                        //         backgroundColor: Colors.black,
                        //         child: Image.asset('assets/images/mail1.png'),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        IconButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Text(
                          'What is ',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Drives City ?',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'Drives City is proud to offer our customers a wide range of vehicles to suit their needs, from economy cars to luxury SUVs.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'Our fleet is regularly maintained and serviced to ensure that our customers have a safe and comfortable journey.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'In addition to car rental, we also offer a variety of services such as airport pick-up and drop-off, 24-hour roadside assistance, and GPS navigation systems.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'We understand that our customers have different needs and preferences, which is why we offer flexible rental options including daily, weekly, and monthly rentals.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Our values:',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'Drives City is a premium car rental marketplace in Dubai. With us, you\'ll have an unforgettable driving experience thanks to our large catalog of sophisticated, modern and high-tech vehicles wherever you are.',
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
