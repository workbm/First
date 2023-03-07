import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';
import '../../providers/search_by_filter_provider.dart';

class SeatsWidget extends StatefulWidget {
  const SeatsWidget({super.key});

  @override
  State<SeatsWidget> createState() => _SeatsWidgetState();
}

class _SeatsWidgetState extends State<SeatsWidget> {
  static const _seats = ['1', '2', '4 - 5', '6 - 7', '8 - 12'];
  var _isPressed = false;
  var _list = [];
  var _indexLists = [];
  void _clickFct(int listIndex) {
    context.read<FilterProvider>().filterPressedFct(true);
    // context.read<SearchByFilterProvider>().selectSeatsFct();

    if (listIndex == 0) {
      setState(() {
        _indexLists = _indexLists + [0];
        _list = _list + [1];
        _isPressed = true;
      });
    }
    if (listIndex == 1) {
      setState(() {
        _indexLists = _indexLists + [1];
        _list = _list + [2];
        _isPressed = true;
      });
    }
    if (listIndex == 2) {
      setState(() {
        _indexLists = _indexLists + [2];
        _list = _list + [2, 4];
        _isPressed = true;
      });
    }
    if (listIndex == 3) {
      setState(() {
        _indexLists = _indexLists + [3];
        _list = _list + [6, 7];
        _isPressed = true;
      });
    }
    if (listIndex == 4) {
      setState(() {
        _indexLists = _indexLists + [4];
        _list = _list + [8, 12];
        _isPressed = true;
      });
    }
    context.read<SearchByFilterProvider>().mapFct("pass", _list);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _seats.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // if (context
            //     .watch<SearchByFilterProvider>()
            //     .isDeleteFunctionGetPressed) {
            //   _indexLists = [];
            // }
            _clickFct(index);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                    color: _isPressed && _indexLists.contains(index)
                        // &&
                        // context.watch<SearchByFilterProvider>().selectSeats
                        ? Theme.of(context).primaryColor
                        : GeneralData.borderColor)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.airline_seat_recline_normal),
                Text(
                  _seats[index].toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
