import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/filter_provider.dart';
import '../../providers/search_by_filter_provider.dart';

class FeaturesWidget extends StatefulWidget {
  const FeaturesWidget({super.key});

  @override
  State<FeaturesWidget> createState() => _FeaturesWidgetState();
}

class _FeaturesWidgetState extends State<FeaturesWidget> {
  List<int> _list = [];
  List<int> _listGesture = [];

  var _isPressed = false;
  void _clickFct(int featureId) {
    context.read<FilterProvider>().filterPressedFct(true);
    setState(() {
      _isPressed = true;
      _list = _list + [featureId];
      _listGesture = _listGesture + [featureId - 1];
    });
    context.read<SearchByFilterProvider>().mapFct("fea", _list);
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<FilterProvider>();

    return SizedBox(
      // width: double.infinity,
      height: 250.h,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listenData.features.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            _clickFct(listenData.features[index].id);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
                border: Border.all(
                    color: _isPressed && _listGesture.contains(index)
                        ? Theme.of(context).primaryColor
                        : GeneralData.borderColor),
                borderRadius: BorderRadius.circular(15.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.network(listenData.features[index].image,
                    height: 25.h, width: 25.w),
                SizedBox(width: 5.w),
                SizedBox(
                  width: 140.w,
                  child: AutoSizeText(
                    listenData.features[index].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
