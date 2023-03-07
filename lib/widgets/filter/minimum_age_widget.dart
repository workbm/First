import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';
import '../../providers/search_by_filter_provider.dart';

class MinimumAgeWidget extends StatefulWidget {
  const MinimumAgeWidget({super.key});

  @override
  State<MinimumAgeWidget> createState() => _MinimumAgeWidgetState();
}

class _MinimumAgeWidgetState extends State<MinimumAgeWidget> {
  var _isPressed = false;
  var _index = 0;
  void _clickFct(int age) {
    context.read<FilterProvider>().filterPressedFct(true);
    setState(() {
      _isPressed = true;
      _index = age;
    });
    context.read<SearchByFilterProvider>().mapFct("min_required_age", age);
  }

  @override
  Widget build(BuildContext context) {
    final minimum = List<int>.generate(13, (index) => index + 18);
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: minimum.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            _clickFct(minimum[index]);
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
                  color: _isPressed && _index == minimum[index]
                      ? Theme.of(context).primaryColor
                      : GeneralData.borderColor,
                ),
              ),
              child: Center(
                child: Text(
                  minimum[index].toString(),
                ),
              )),
        ),
      ),
    );
  }
}
