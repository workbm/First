import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecContainerWidget extends StatelessWidget {
  const SpecContainerWidget(
      {super.key, required this.widget, required this.isWidth});
  final Widget widget;
  final bool isWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 0.1,
                  spreadRadius: 1,
                  color: Color.fromARGB(255, 221, 221, 221)),
            ]),
        padding: isWidth
            ? EdgeInsets.fromLTRB(15.w, 15.h, 0, 15.h)
            : EdgeInsets.all(15.r),
        child: widget);
  }
}
