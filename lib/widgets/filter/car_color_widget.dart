import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';
import '../../providers/search_by_filter_provider.dart';

class CarColorsWidget extends StatefulWidget {
  const CarColorsWidget({super.key});

  @override
  State<CarColorsWidget> createState() => _CarColorsWidgetState();
}

class _CarColorsWidgetState extends State<CarColorsWidget> {
  List<int> _list = [];
  List<int> _listGesture = [];

  var _isPressed = false;
  void _clickFct(int colorId) {
    context.read<FilterProvider>().filterPressedFct(true);
    setState(() {
      _isPressed = true;
      _list = _list + [colorId];
      _listGesture = _listGesture + [colorId - 1];
    });
    context.read<SearchByFilterProvider>().mapFct("clr", _list);
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<FilterProvider>();

    return SizedBox(
      height: 100.h,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listenData.brands.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          height: 68.h,
          width: 68.w,
          margin: EdgeInsets.only(right: 17.w),
          decoration: BoxDecoration(
              border: Border.all(
                  color: _isPressed && _listGesture.contains(index)
                      ? Theme.of(context).primaryColor
                      : Colors.transparent),
              shape: BoxShape.circle),
          child: Center(
            child: GestureDetector(
              onTap: () {
                _clickFct(listenData.colors[index].id);
              },
              child: Container(
                height: 64.h,
                width: 64.w,
                decoration: BoxDecoration(
                  color: Color(int.parse(listenData.colors[index].value)),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: GeneralData.borderColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
