import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/models/car.dart';
import 'package:dream_access/screens/car_detail.dart';
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
    const assetList = [
      'assets/images/image20.png',
      'assets/images/image21.png',
    ];
    // final cars = [
    //   Car(
    //       id: 1,
    //       name: 'Tesla model 3',
    //       image: 'assets/images/image20.png',
    //       type: 'Sedan',
    //       price: 'AED 599 / day 250 km',
    //       options: [
    //         '1 day rental available',
    //         'Deposit: AED 50',
    //         'Insurance included',
    //         'Free delivery',
    //       ]),
    //   Car(
    //       id: 1,
    //       name: 'Chevrolet Camaro',
    //       image: 'assets/images/image20.png',
    //       type: 'Sedan',
    //       price: 'AED 999 / day 250 km',
    //       options: [
    //         '2 day rental available',
    //         'Deposit: AED 300',
    //         'Insurance included',
    //         'Free delivery',
    //       ])
    // ];

    const description = [
      [
        'Tesla model 3',
        'AED 599 / day 250 km',
        '1 day rental available',
        'Deposit: AED 50',
        'Insurance included',
        'Free delivery',
      ],
      [
        'Chevrolet Camaro',
        'AED 999 / day 250 km',
        '1 day rental available',
        'Deposit: AED 300',
        'Insurance included',
        'Free delivery',
      ],
    ];

    const vectorName = [
      'Sedan',
      '4 Doors',
      '4 Passengers',
      'Cruise Control',
    ];
    // Future<void> _launchUrl() async {
    //   if (!await launchUrl(_url)) {
    //     throw Exception('Could not launch $_url');
    //   }
    // }
    void _openWhatsApp() async {
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
          Row(
            children: [
              Text(
                car.name,
                // description[index][0],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text(
                car.price,
                // description[index][1],
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            children: [
              SizedBox(width: 20.w),
              CircleAvatar(
                radius: 3.r,
                backgroundColor: Colors.black,
              ),
              SizedBox(width: 5.w),
              Text(car.options[0]
                  // description[index][2],
                  ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20.w),
              CircleAvatar(
                radius: 3.r,
                backgroundColor: Colors.black,
              ),
              SizedBox(width: 5.w),
              Text(car.options[1]
                  // description[index][3],
                  ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20.w),
              CircleAvatar(
                radius: 3.r,
                backgroundColor: Colors.black,
              ),
              SizedBox(width: 5.w),
              Text(car.options[2]
                  // description[index][4],
                  ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 20.w),
              CircleAvatar(
                radius: 3.r,
                backgroundColor: Colors.black,
              ),
              SizedBox(width: 5.w),
              Text(car.options[3]
                  // description[index][5],
                  ),
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
                  _openWhatsApp();
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
              Container(
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
            ],
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
