// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class FuturesWidget extends StatelessWidget {
//   const FuturesWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Car features',
//           style: Theme.of(context).textTheme.headline1,
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 18.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 15.h),
//               Row(
//                 children: [
//                   widget.car.features != []
//                       ? CachedNetworkImage(
//                           imageUrl: widget.car.features != []
//                               ? widget.car.features[0].image
//                               : '',
//                           height: 20.h,
//                           width: 20.w)
//                       : Image.asset('assets/images/vector14.png',
//                           height: 20.h, width: 20.w),
//                   SizedBox(width: 5.w),
//                   SizedBox(
//                       width: 140.w,
//                       child: widget.car.transmissionType == 1
//                           ? const AutoSizeText(
//                               'Transmission: AUTO',
//                               maxLines: 1,
//                               maxFontSize: 14,
//                             )
//                           : const AutoSizeText(
//                               'Transmission: MANUAL',
//                               maxLines: 1,
//                               maxFontSize: 14,
//                             )),
//                   SizedBox(width: 30.w),
//                   const Icon(
//                     Icons.car_rental,
//                     color: Colors.red,
//                   ),
//                   SizedBox(width: 5.w),
//                   SizedBox(
//                     child: SizedBox(
//                         width: 85.w,
//                         child: AutoSizeText(
//                           widget.car.type,
//                           maxLines: 1,
//                         )),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 children: [
//                   Image.asset('assets/images/vector13Red.png',
//                       height: 24, width: 24),
//                   SizedBox(width: 5.w),
//                   SizedBox(
//                       width: 140.w,
//                       child: AutoSizeText(
//                         '${widget.car.doors} doors',
//                         maxFontSize: 14,
//                         maxLines: 1,
//                       )),
//                   SizedBox(width: 30.w),
//                   Icon(
//                     Icons.backpack,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   SizedBox(width: 5.w),
//                   Text('${widget.car.seat} seats'),
//                 ],
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 children: [
//                   Image.asset('assets/images/vector13Red.png',
//                       height: 24, width: 24),
//                   SizedBox(width: 5.w),
//                   SizedBox(
//                     width: 140.w,
//                     child: widget.car.specsType == 1
//                         ? const AutoSizeText(
//                             'GCC specs: YES',
//                             maxLines: 1,
//                             maxFontSize: 14,
//                           )
//                         : const AutoSizeText(
//                             'GCC specs: NO',
//                             maxLines: 1,
//                             maxFontSize: 14,
//                           ),
//                   ),
//                   SizedBox(width: 30.w),
//                   const Icon(
//                     Icons.backpack,
//                     color: Colors.red,
//                   ),
//                   SizedBox(width: 5.w),
//                   Text('${widget.car.bags} Bag(s)'),
//                 ],
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 children: [
//                   const Icon(Icons.engineering),
//                   SizedBox(width: 5.w),
//                   Text('Engine capacity: ${widget.car.engineCapacity}L')
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
