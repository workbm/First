import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key, required this.options});
  final List<String> options;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: options
          .map(
            (e) => Row(children: [
              CircleAvatar(
                radius: 3.r,
                backgroundColor: Colors.black,
              ),
              SizedBox(width: 5.w),
              SizedBox(
                width: 150.w,
                child: Text(
                  e,
                  // style: TextStyle(fontSize: 12),
                ),
              ),
            ]),
          )
          .toList(),
      // Row(
      //   children: [
      //     SizedBox(width: 20.w),
      //     CircleAvatar(
      //       radius: 3.r,
      //       backgroundColor: Colors.black,
      //     ),
      //     SizedBox(width: 5.w),
      //     Text(options[1]
      //         // description[index][3],
      //         ),
      //   ],
      // ),
      // Row(
      //   children: [
      //     SizedBox(width: 20.w),
      //     CircleAvatar(
      //       radius: 3.r,
      //       backgroundColor: Colors.black,
      //     ),
      //     SizedBox(width: 5.w),
      //     Text(options[2]
      //         // description[index][4],
      //         ),
      //   ],
      // ),
      // Row(
      //   children: [
      //     SizedBox(width: 20.w),
      //     CircleAvatar(
      //       radius: 3.r,
      //       backgroundColor: Colors.black,
      //     ),
      //     SizedBox(width: 5.w),
      //     Text(options[3]
      //         // description[index][5],
      //         ),
      //   ],
      // ),
      // ],
    );
  }
}
