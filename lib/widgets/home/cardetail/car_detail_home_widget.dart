import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/models/car.dart';
import 'package:dream_access/providers/statistics_provider.dart';
import 'package:dream_access/screens/agency/agency_screen.dart';
import 'package:dream_access/screens/car_detail/car_detail.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/home/cardetail/options_widget.dart';
import 'package:dream_access/widgets/home/vectors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'favorite_widget.dart';

class CarDetailHomeWidget extends StatelessWidget {
  const CarDetailHomeWidget({
    super.key,
    required this.car,
  });
  final Car car;

  @override
  Widget build(BuildContext context) {
    // Future<void> _launchUrl() async {
    //   if (!await launchUrl(_url)) {
    //     throw Exception('Could not launch $_url');
    //   }
    // }
    void openWhatsApp(int carID) async {
      await context
          .read<StatisticsProvider>()
          .staticsFct(2, carID)
          .then((_) async {
        await canLaunch(
                'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
            ? await launch(
                'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
            : throw 'Could not launch WhatsApp';
      });

      // const phoneNumber = '212682711880';
      // var url = Uri.parse('https://wa.me/$phoneNumber');
      // // if (await canLaunchUrl(url)) {
      // await launchUrl(url);
      // // } else {
      // // print('Error');
      // // throw 'Error occured';
      // // }
    }

    Future openMailApp(int carID, String agencyName, String carName) async {
      const mailTo = 'azzi.youssef@excelenciatech.com';
      const subject = 'Inquiry to rent';
      var message =
          'Hello, \n\nI am writing this letter to your agency $agencyName for the purpose of renting the $carName displayed on the app Drivers City and I would like to know whether the said car is available with you or not. As I am in a hurry I would be very grateful if you could mail me the conditions’ rent.\n\nI hope that you would revert back to me as soon as possible with the necessary details.\n\nThanking you,\n\nSincerely';
      final url =
          'mailto:$mailTo?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
      await context
          .read<StatisticsProvider>()
          .staticsFct(3, carID)
          .then((_) async {
        // if (await canLaunch(url)) {
        launch(url);
        // }
      });
    }

    _launchURL() async {
      const url = 'https://en.wikipedia.org/wiki/Body_mass_index';
      if (await launch(url)) {
        await canLaunch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> phone(int carID) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: '+1-555-010-999',
      );
      await context
          .read<StatisticsProvider>()
          .staticsFct(1, carID)
          .then((_) async {
        await launchUrl(launchUri);
      });
    }

    void navigateToAgency() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgencyScreen(agencyId: car.agence[0].id),
          ));
    }

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(
          bottom: 15.h, left: GeneralData.width, right: GeneralData.width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xffD0D0D0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarDetail(car: car),
                      ));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: car.image[0],
                    width: double.infinity,
                    height: 220.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              FavoriteWidget(carID: car.id),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.name,
                  // description[index][0],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 21),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'AED ',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          car.priceByDay.toString(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const Text(
                          '/day',
                          // style: TextStyle(fontSize: 9),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          height: 15.h,
                          width: 3,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'AED ',
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          car.priceByWeek.toString(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const Text(
                          '/week',
                          // style: TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(height: 7),
                Row(
                  children: [
                    Image.asset('assets/images/km.png'),
                    SizedBox(width: 10.w),
                    Text(
                      '${car.kmPerDay}  Km',
                      style: TextStyle(
                          fontSize: GeneralData.kmFontSize.toDouble()),
                    ),
                  ],
                ),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigateToAgency();
                      },
                      child: SizedBox(
                        height: 115.h,
                        width: 115.w,
                        child: FittedBox(
                            child: CachedNetworkImage(
                          imageUrl: car.agencyLogo,
                        )),
                      ),
                    ),
                    SizedBox(width: 25.w),
                    OptionsWidget(options: car.options),
                  ],
                ),
                SizedBox(height: 15.h),
                VectorsWidget(car: car),
                SizedBox(height: 15.h),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          phone(car.id);
                        },
                        child: Container(
                          height: 50.h,
                          // width: 115.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/appel1.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          openWhatsApp(car.id);
                        },
                        child: Container(
                          height: 50.h,
                          // width: 115.w,
                          decoration: BoxDecoration(
                            color: GeneralData.whatsAppColor,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/watssap.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          openMailApp(car.id, car.agencyName, car.name);
                        },
                        child: Container(
                          height: 50.h,
                          // width: 115.w,
                          decoration: BoxDecoration(
                            color: const Color(0xff262626),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/mail1.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
