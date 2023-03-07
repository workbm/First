import 'package:dream_access/models/car_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/search_by_filter_provider.dart';

class ModelsWidget extends StatefulWidget {
  const ModelsWidget({super.key, required this.list});
  final List<CarModels> list;

  @override
  State<ModelsWidget> createState() => _ModelsWidgetState();
}

class _ModelsWidgetState extends State<ModelsWidget> {
  var _modelIndex = 0;
  var _isModelPressed = false;
  void _clickModelFct(int modelId) {
    context.read<SearchByFilterProvider>().mapFct("modelCar", modelId);
    setState(() {
      _isModelPressed = true;
      _modelIndex = modelId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            _clickModelFct(widget.list[index].id);
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
                color: _isModelPressed && _modelIndex == widget.list[index].id
                    ? Theme.of(context).primaryColor
                    : GeneralData.borderColor,
              ),
            ),
            child: Center(child: Text(widget.list[index].name)),
          ),
        ),
      ),
    );
  }
}
