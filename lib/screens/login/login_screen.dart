import 'package:animate_do/animate_do.dart';
import 'package:dream_access/screens/login/verify_phone.dart';
import 'package:dream_access/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final _phoneController = TextEditingController();
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Container(
              height: size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bmBackground.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: double.infinity,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  FadeInDown(
                    child: Container(
                      width: 286.w,
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 189, 188, 188),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InternationalPhoneNumberInput(
                                selectorConfig: const SelectorConfig(
                                  leadingPadding: 0,
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                inputDecoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone number',
                                ),
                                onInputChanged: (value) {},
                              ),
                              Positioned(
                                top: 5.h,
                                bottom: 5.h,
                                left: 90.w,
                                child: Container(
                                  color: Colors.black,
                                  height: 40.h,
                                  width: 1,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 42.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r)),
                      fixedSize: Size(138.w, 48.h),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerifiyPhone(),
                        ),
                      );
                    },
                    child: const Text('Submit'),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: Divider(
                  //       thickness: 1.h,
                  //       color: Colors.black,
                  //     )),
                  //     Container(
                  //       height: 39.h,
                  //       width: 39.w,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border:
                  //             Border.all(color: Theme.of(context).primaryColor),
                  //       ),
                  //       padding: EdgeInsets.all(5.r),
                  //       child: const Center(child: Text('OR')),
                  //     ),
                  //     Expanded(
                  //         child: Divider(
                  //       thickness: 1.h,
                  //       color: Colors.black,
                  //     )),
                  //   ],
                  // ),

                  // SizedBox(
                  //   height: 75.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       height: 74.h,
                  //       width: 74.w,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border:
                  //             Border.all(color: Theme.of(context).primaryColor),
                  //       ),
                  //       // padding: EdgeInsets.all(5.r),
                  //       child: Center(
                  //           child: Image.asset(
                  //         'assets/images/IconeFaceBook.png',
                  //         fit: BoxFit.cover,
                  //         height: 55.h,
                  //         width: 55.w,
                  //       )),
                  //     ),
                  //     SizedBox(
                  //       width: 7.w,
                  //     ),
                  //     Container(
                  //       height: 74.h,
                  //       width: 74.w,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border:
                  //             Border.all(color: Theme.of(context).primaryColor),
                  //       ),
                  //       // padding: EdgeInsets.all(5.r),
                  //       child: Center(
                  //           child: Image.asset(
                  //         'assets/images/Google.png',
                  //         fit: BoxFit.cover,
                  //         height: 35.h,
                  //         width: 35.w,
                  //       )),
                  //     ),
                  //   ],
                  // ),

                  // SizedBox(height: 90.h),
                  // SizedBox(
                  //   height: 350.h,
                  //   width: double.infinity,
                  //   child: Image.asset(
                  //     'assets/images/generic-brandless-modern-sport-car-with-fire-smoke1.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // Image.asset(
                  //   'assets/images/BackgroundSimple.png',
                  //   width: 270.w,
                  //   // height: 100.h,
                  // ),
                  // Container(
                  //   height: 1.h,
                  //   width: 270,
                  //   color: Colors.black,
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
