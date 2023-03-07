import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';
import '../../providers/search_by_filter_provider.dart';

class VehicleTypeWidget extends StatefulWidget {
  const VehicleTypeWidget({super.key});

  @override
  State<VehicleTypeWidget> createState() => _VehicleTypeWidgetState();
}

class _VehicleTypeWidgetState extends State<VehicleTypeWidget> {
  var _isPressed = false;
  List _list = [];
  void _clickFct(int vehicleId) {
    context.read<FilterProvider>().filterPressedFct(true);
    setState(() {
      _isPressed = true;
      _list = _list + [vehicleId];
    });
    context.read<SearchByFilterProvider>().mapFct("group", _list);
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<FilterProvider>();
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listenData.carType.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            _clickFct(listenData.carType[index].id);
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
                color:
                    _isPressed && _list.contains(listenData.carType[index].id)
                        ? Theme.of(context).primaryColor
                        : GeneralData.borderColor,
              ),
            ),
            child: Center(
              child: Text(listenData.carType[index].name),
            ),
          ),
        ),
      ),
    );
  }
}
