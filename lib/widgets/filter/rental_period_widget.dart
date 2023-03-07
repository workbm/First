import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';
import '../../providers/search_by_filter_provider.dart';

class RentalPeriod extends StatefulWidget {
  const RentalPeriod({super.key});

  @override
  State<RentalPeriod> createState() => _RentalPeriodState();
}

class _RentalPeriodState extends State<RentalPeriod> {
  var periods = List<int>.generate(30, (index) => index + 1);
  var _isPressed = false;
  var _index = 0;
  void _clickFct(int day) {
    context.read<FilterProvider>().filterPressedFct(true);
    setState(() {
      _isPressed = true;
      _index = day;
    });
    context.read<SearchByFilterProvider>().mapFct("min_days_booking", day);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            _clickFct(periods[index]);
          },
          child: Container(
            // height: 64.h,
            // width: 64.w,
            margin: EdgeInsets.only(right: 17.w),
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: _isPressed && _index == periods[index]
                    ? Theme.of(context).primaryColor
                    : GeneralData.borderColor,
              ),
            ),
            child: Center(
              child: Text(periods[index].toString()),
            ),
          ),
        ),
      ),
    );
  }
}
