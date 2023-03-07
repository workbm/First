import 'package:dream_access/providers/search_by_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';

class ModelYearWidget extends StatefulWidget {
  const ModelYearWidget({super.key});

  @override
  State<ModelYearWidget> createState() => _ModelYearWidgetState();
}

class _ModelYearWidgetState extends State<ModelYearWidget> {
  var _isPressed = false;
  var _index = 0;
  void _clickFct(int index) {
    context.read<FilterProvider>().filterPressedFct(true);
    // context.read<SearchByFilterProvider>().selectModelYearFct();
    context.read<SearchByFilterProvider>().mapFct("year", index);
    setState(() {
      _isPressed = true;
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const years = [
      2023,
      2022,
      2021,
      2020,
      2019,
      2018,
      2017,
      2016,
      2015,
      2014,
      2013,
      2012,
      2011,
      2010
    ];
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: years.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            _clickFct(years[index]);
            print('pressed');
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
                color: _isPressed && _index == years[index]
                    //  &&
                    // context.watch<SearchByFilterProvider>().modelYear
                    ? Theme.of(context).primaryColor
                    : GeneralData.borderColor,
              ),
            ),
            child: Center(
              child: Text(years[index].toString()),
            ),
          ),
        ),
      ),
    );
  }
}
