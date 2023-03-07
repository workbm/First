import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/models/car.dart';
import 'package:dream_access/providers/statistics_provider.dart';
import 'package:dream_access/screens/agency/agency_screen.dart';
import 'package:dream_access/screens/agency/car_detail_agency.dart';
import 'package:dream_access/screens/car_detail/car_detail.dart';
import 'package:dream_access/widgets/home/cardetail/options_widget.dart';
import 'package:dream_access/widgets/home/vectors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CarWidget extends StatelessWidget {
  const CarWidget({
    super.key,
    required this.car,
  });
  final Car car;

  @override
  Widget build(BuildContext context) {
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
          'Hello, \n\nI am writing this letter to your agency $agencyName for the purpose of renting the $carName displayed on the app Drivers City and I would like to know whether the said car is available with you or not. As I am in a hurry I would be very grateful if you could mail me the conditions\’ rent.\n\nI hope that you would revert back to me as soon as possible with the necessary details.\n\nThanking you,\n\nSincerely';
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(
          bottom: 15.h, left: GeneralData.width, right: GeneralData.width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: GeneralData.borderColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailAgency(car: car),
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CachedNetworkImage(
                imageUrl: car.image[0],
                width: double.infinity,
                height: 220.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            car.name,
            // description[index][0],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
          SizedBox(height: 7.h),
          Row(
            children: [
              SizedBox(
                height: 115.h,
                width: 115.w,
                child: FittedBox(
                    child: CachedNetworkImage(
                  imageUrl: car.agencyLogo,
                )),
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
    );
  }
}
