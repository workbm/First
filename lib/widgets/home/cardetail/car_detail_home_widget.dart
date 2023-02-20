import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/models/car.dart';
import 'package:dream_access/screens/car_detail/car_detail.dart';
import 'package:dream_access/widgets/home/cardetail/options_widget.dart';
import 'package:dream_access/widgets/home/vectors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
    void openWhatsApp() async {
      await canLaunch(
              'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
          ? await launch(
              'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
          : throw 'Could not launch WhatsApp';
      // const phoneNumber = '212682711880';
      // var url = Uri.parse('https://wa.me/$phoneNumber');
      // // if (await canLaunchUrl(url)) {
      // await launchUrl(url);
      // // } else {
      // // print('Error');
      // // throw 'Error occured';
      // // }
    }

    Future openMailApp() async {
      const mailTo = 'azzi.youssef@excelenciatech.com';
      const subject = 'I want to rent a car';
      const message = 'I want more information about the car';
      final url =
          'mailto:$mailTo?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

      if (await canLaunch(url)) {
        launch(url);
      }
      print('err in LaunchUrl:');
    }

    _launchURL() async {
      const url = 'https://en.wikipedia.org/wiki/Body_mass_index';
      if (await launch(url)) {
        await canLaunch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(
          bottom: 15.h, left: GeneralData.width, right: GeneralData.width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: const Color(0xffD0D0D0),
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
                    builder: (context) => CarDetail(car: car),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: '+1-555-010-999',
                  );
                  await launchUrl(launchUri);
                },
                child: Container(
                  height: 60.h,
                  width: 105.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/appel1.png',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  openWhatsApp();
                },
                child: Container(
                  height: 60.h,
                  width: 105.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/watssap.png',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: openMailApp,
                child: Container(
                  height: 60.h,
                  width: 105.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/mail1.png',
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
