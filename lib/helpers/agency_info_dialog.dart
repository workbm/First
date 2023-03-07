import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/models/agency/work_day.dart';
import 'package:dream_access/providers/agency_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/general_data.dart';
import '../widgets/helpers/gap_widget.dart';

agencyInfoDialog(BuildContext context) {
  var listenData = context.read<AgencyProvider>();
  String openTime(String day) {
    var data = listenData.agency[0].workDays
        .firstWhere((element) => element.name == day);
    return data.name;
  }

  WorkDay workDay(String day) {
    var data = listenData.agency[0].workDays
        .firstWhere((element) => element.name == day);
    return data;
  }

  return showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          // height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (listenData.agency[0].isVerified == 1)
                      const Icon(
                        Icons.verified,
                        color: Colors.green,
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        iconSize: 35.r,
                        icon: const Icon(Icons.clear, color: Colors.black))
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
                            imageUrl: listenData.agency[0].logo,
                            fit: BoxFit.cover,
                          )),
                      const Gap(height: 10),
                      AutoSizeText(
                        listenData.agency[0].name,
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
                        listenData.agency[0].descritpion,
                      ),
                      const Gap(height: 10),
                    ],
                  ),
                ),
                const Gap(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: GeneralData.borderColor),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          print('buttonClickedFct 1');
                        },
                        child: ListTile(
                          onTap: () {
                            print('buttonClickedFct');
                            listenData.buttonClickedFct(true);
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.schedule,
                              ),
                              SizedBox(width: 4.w),
                              if (workDay(DateFormat.EEEE()
                                          .format(DateTime.now())
                                          .toLowerCase())
                                      .openAllDay ==
                                  1)
                                const Text('Open 24 hours'),
                              if (workDay(DateFormat.EEEE()
                                          .format(DateTime.now())
                                          .toLowerCase())
                                      .closedAllDay ==
                                  1)
                                const Text('Closed 24 hours'),
                              if (workDay(DateFormat.EEEE()
                                      .format(DateTime.now())
                                      .toLowerCase())
                                  .start
                                  .isNotEmpty)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(workDay(DateFormat.EEEE()
                                            .format(DateTime.now())
                                            .toLowerCase())
                                        .start),
                                    Text(workDay(DateFormat.EEEE()
                                            .format(DateTime.now())
                                            .toLowerCase())
                                        .end),
                                  ],
                                )
                            ],
                          ),
                          trailing: const Icon(Icons.expand_more),
                        ),
                      ),
                      listenData.buttonClicked
                          ? Column(
                              children: listenData.agency[0].workDays
                                  .map(
                                    (e) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.schedule,
                                          ),
                                          SizedBox(width: 4.w),
                                          if (e.openAllDay == 1)
                                            const Text('Open 24 hours'),
                                          if (e.closedAllDay == 1)
                                            const Text('Closed 24 hours'),
                                          if (e.start.isNotEmpty)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(e.start),
                                                Text(e.end),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : const SizedBox(),
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
                      const Gap(height: 10),
                      Text(
                        'Phone',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(listenData.agency[0].phone),
                      const Gap(height: 10),
                      Text(
                        'WhatsApp',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(listenData.agency[0].wtspPhone),
                      const Gap(height: 10),
                      Text(
                        'Country',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(listenData.agency[0].country),
                      const Gap(height: 10),
                      Text(
                        'Address',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const Gap(height: 10),
                      Text(listenData.agency[0].address),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
