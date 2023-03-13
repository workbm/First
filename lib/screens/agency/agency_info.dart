import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/models/agency/agency.dart';
import 'package:dream_access/screens/agency/map.dart';
import 'package:dream_access/widgets/agency/time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/general_data.dart';
import '../../widgets/helpers/gap_widget.dart';

class AgencyInfo extends StatelessWidget {
  const AgencyInfo({super.key, required this.agency});
  final Agency agency;

  @override
  Widget build(BuildContext context) {
    void openWhatsApp(String whatsApp) async {
      await canLaunch(
              'https://api.whatsapp.com/send?phone=$whatsApp&text=Hello%2c')
          ? await launch(
              'https://api.whatsapp.com/send?phone=$whatsApp&text=Hello%2c')
          : throw 'Could not launch WhatsApp';
    }

    Future openMailApp(String agencyName) async {
      const mailTo = 'azzi.youssef@excelenciatech.com';
      const subject = 'Inquiry to rent';
      var message =
          'Hello, \n\nI am writing this letter to your agency $agencyName to get more information.';
      final url =
          'mailto:$mailTo?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
      await launch(url);
    }

    Future<void> phone(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: GeneralData.width),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 35.r,
                      icon: const Icon(Icons.clear, color: Colors.black),
                    ),
                    const Spacer(),
                    if (agency.isVerified == 1)
                      const Icon(
                        Icons.verified,
                        color: Colors.green,
                      ),
                  ],
                ),
                const Gap(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: GeneralData.borderColor),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          color: Colors.amber,
                          height: 100.h,
                          width: 115.w,
                          child: CachedNetworkImage(
                            imageUrl: agency.logo,
                            fit: BoxFit.cover,
                          )),
                      const Gap(height: 10),
                      AutoSizeText(
                        agency.name,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                phone(agency.phone);
                              },
                              child: Container(
                                height: 70.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                  // borderRadius: BorderRadius.circular(15.r),
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
                                var wts = agency.wtspPhone.substring(1);
                                openWhatsApp(wts);
                              },
                              child: Container(
                                height: 70.h,
                                width: 70.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: GeneralData.whatsAppColor,
                                  // borderRadius: BorderRadius.circular(15.r),
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
                                openMailApp(agency.name);
                              },
                              child: Container(
                                height: 70.h,
                                width: 70.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff262626),
                                  // borderRadius: BorderRadius.circular(15.r),
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
                    ],
                  ),
                ),
                const Gap(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: GeneralData.borderColor),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      const Gap(height: 10),
                      Text(
                        agency.descritpion,
                      ),
                      const Gap(height: 10),
                    ],
                  ),
                ),
                const Gap(height: 10),
                Schedule(workDays: agency.workDays),
                const Gap(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: GeneralData.borderColor),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(height: 10),
                      Text(
                        'Country',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(agency.country),
                      const Gap(height: 10),
                      Text(
                        'Address',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(agency.address),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  height: 220.h,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: MapSample(y: agency.y, x: agency.x)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
