import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/constants/list_cars.dart';
import 'package:dream_access/widgets/home/best_offers_widget.dart';
import 'package:dream_access/widgets/home/vectors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'gen/assets.gen.dart';
// import 'gen/colors.gen.dart';
// import 'gen/fonts.gen.dart';

import '../models/car.dart';

class CarDetail extends StatelessWidget {
  const CarDetail({super.key, required this.car});
  final Car car;

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
                              imageUrl: car.image[0],
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
                          car.name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          car.price,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    VectorsWidget(car: car),
                    SizedBox(height: 15.h),
                    ...car.options.map(
                      (e) => Row(
                        children: [
                          CircleAvatar(
                            radius: 3.r,
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(width: 10.w),
                          Text(e),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5.w),
                          child: CircleAvatar(
                            radius: 3.r,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          width: 320.w,
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text(
                            car.description,
                          ),
                        ),
                      ],
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
