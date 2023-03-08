// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../signup/password.dart';

// class VerifiyPhone extends StatefulWidget {
//   const VerifiyPhone({super.key});

//   @override
//   State<VerifiyPhone> createState() => _VerifiyPhoneState();
// }

// class _VerifiyPhoneState extends State<VerifiyPhone> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       // appBar: appBar(context) as AppBar,
//       body: SingleChildScrollView(
//         child: Container(
//           height: size.height,
//           width: size.width,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/images/bmBackground.png"),
//                 fit: BoxFit.cover),
//           ),
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 150.h,
//                 ),
//                 Text(
//                   'Verify',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 27,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 33.h),
//                 const Text(
//                   'Please enter the 4-digit code \nsent to your email',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 17,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 100.h),
//                 FadeInDown(
//                   child: Container(
//                     width: 286.w,
//                     padding: const EdgeInsets.symmetric(horizontal: 13),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 189, 188, 188),
//                       border: Border.all(
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [
//                             TextFormField(
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                   hintText: 'Code...',
//                                   border: InputBorder.none),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 50.h),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25.r)),
//                     fixedSize: Size(138.w, 48.h),
//                     backgroundColor: Theme.of(context).primaryColor,
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const Password(isEmail: true),
//                       ),
//                     );
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
