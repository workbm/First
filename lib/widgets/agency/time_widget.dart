import 'package:dream_access/models/agency/work_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../constants/general_data.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key, required this.workDays});
  final List<WorkDay> workDays;
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  var _isPressed = false;
  WorkDay _workDay(String day) {
    var data = widget.workDays.firstWhere((element) => element.name == day);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: GeneralData.borderColor),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _isPressed = !_isPressed;
                print('buttonClickedFct');
              });
            },
            contentPadding: EdgeInsets.zero,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.schedule,
                ),
                SizedBox(width: 4.w),
                if (_workDay(DateFormat.EEEE()
                            .format(DateTime.now())
                            .toLowerCase())
                        .openAllDay ==
                    1)
                  const Text('Open 24 hours'),
                if (_workDay(DateFormat.EEEE()
                            .format(DateTime.now())
                            .toLowerCase())
                        .closedAllDay ==
                    1)
                  const Text('Closed 24 hours'),
                if (_workDay(
                        DateFormat.EEEE().format(DateTime.now()).toLowerCase())
                    .start
                    .isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_workDay(DateFormat.EEEE()
                              .format(DateTime.now())
                              .toLowerCase())
                          .start),
                      Text(_workDay(DateFormat.EEEE()
                              .format(DateTime.now())
                              .toLowerCase())
                          .end),
                    ],
                  )
              ],
            ),
            trailing: const Icon(Icons.expand_more),
          ),
          _isPressed
              ? Column(
                  children: widget.workDays
                      .map(
                        (e) => Column(
                          children: [
                            // Container(
                            //     width: 150.w,
                            //     height: 1,
                            //     color: Theme.of(context).primaryColor),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              margin: EdgeInsets.only(bottom: 5.h),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 247, 237, 237),
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text('${e.name}: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    SizedBox(width: 15.w),
                                    if (e.openAllDay == 1)
                                      Text(
                                        'Open 24 hours',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (e.closedAllDay == 1)
                                      Text(
                                        'Closed 24 hours',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (e.start.isNotEmpty)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text((e.start).substring(0, 5),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          const Text(' / '),
                                          Text((e.end).substring(0, 5),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
