import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/models/agency/agency.dart';
import 'package:dream_access/widgets/agency/time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/general_data.dart';
import '../../widgets/helpers/gap_widget.dart';

class AgencyInfo extends StatelessWidget {
  const AgencyInfo({super.key, required this.agency});
  final Agency agency;

  @override
  Widget build(BuildContext context) {
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
                        'Phone',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(agency.phone),
                      const Gap(height: 10),
                      Text(
                        'WhatsApp',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(agency.wtspPhone),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
