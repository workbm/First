import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/general_data.dart';
import '../constants/list_cars.dart';
import '../widgets/home/best_offers_widget.dart';
import '../widgets/home/vectors_widget.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    void openWhatsApp() async {
      await canLaunch(
              'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
          ? await launch(
              'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
          : throw 'Could not launch WhatsApp';
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GeneralData.width2,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 299.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 250.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://wallpapercave.com/wp/wp7728785.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 39.r,
                          left: 39.r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final Uri launchUri = Uri(
                                    scheme: 'tel',
                                    path: '+1-555-010-999',
                                  );
                                  await launchUrl(launchUri);
                                },
                                child: CircleAvatar(
                                  radius: 36.r,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child:
                                      Image.asset('assets/images/appel1.png'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  openWhatsApp();
                                },
                                child: CircleAvatar(
                                  radius: 36.r,
                                  backgroundColor: const Color(0xff8BC442),
                                  child:
                                      Image.asset('assets/images/watssap.png'),
                                ),
                              ),
                              CircleAvatar(
                                radius: 36.r,
                                backgroundColor: Colors.black,
                                child: Image.asset('assets/images/mail1.png'),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Text(
                          'About us',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'Oneclickdrive is a car rental platform offering a simple, fast and hassle-free experience. Users can search, compare and book rental cars with just a few clicks.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'The platform offers a wide range of vehicles including economy, luxury, and sports cars. Booking is made easy and convenient, with the website promising reliable and affordable rental services. Enjoy a seamless rental experience with Oneclickdrive.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 38.h),
              BestOffersWidget(
                option: 1,
                car: ListCars.sportCars,
              )
            ],
          ),
        ),
      ),
    );
  }
}
