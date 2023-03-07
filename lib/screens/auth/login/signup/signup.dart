import 'package:animate_do/animate_do.dart';
import 'package:dream_access/models/http_exception.dart';
import 'package:dream_access/providers/auth/signup/email_verification_provider.dart';
import 'package:dream_access/providers/auth/signup/signup_provider.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'verify_phone.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final _phoneController = TextEditingController();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isEmail = true;
  var _isLoading = false;
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An error occurred!'),
        content: Text(errorMessage),
        actions: [
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await context
          .read<EmailVerificationProvider>()
          .emailVerificationFct(_mailController.text)
          .then(
        (value) {
          context.read<SignUpProvider>().getEmail(_mailController.text);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerifiyPhone(isPhone: _isEmail ? true : false),
            ),
          );
        },
      );
    } on HttpException catch (error) {
      var errorMessage = 'Unfortunately, the operation failed';
      if (error.toString().contains('User exist')) {
        errorMessage = 'This e-mail already exists';
      }
      _showErrorDialog(errorMessage);
    } catch (err) {
      const erroMessage = 'Could not authenticate you. Please try again later.';
      _showErrorDialog(erroMessage);
      print('error');
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _mailController.dispose();
    _passwordController.dispose();
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
                  SizedBox(height: 30.h, width: double.infinity),
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(height: 36),
                  FadeInDown(
                    child: Container(
                      width: 286.w,
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 188, 188),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: !_isEmail
                          ? Stack(
                              children: [
                                InternationalPhoneNumberInput(
                                  textFieldController: _phoneController,
                                  selectorConfig: const SelectorConfig(
                                    leadingPadding: 0,
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                  ),
                                  inputDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Phone number',
                                  ),
                                  // onSaved: (value) {
                                  //   print('saved');
                                  // },
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'This field is mandatory';
                                  //   }
                                  //   return null;
                                  // },
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
                            )
                          : _mailWidget(_isEmail),
                    ),
                  ),
                  SizedBox(height: 42.h),
                  _isLoading
                      ? Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.red, size: 50.r),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r)),
                            fixedSize: Size(138.w, 48.h),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            _submit();
                          },
                          child: const Text('Submit'),
                        ),
                  SizedBox(height: 38.h),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 1.h,
                        color: Colors.black,
                      )),
                      Container(
                        height: 39.h,
                        width: 39.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        padding: EdgeInsets.all(5.r),
                        child: const Center(
                            child: Text(
                          'OR',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1.h,
                        color: Colors.black,
                      )),
                    ],
                  ),
                  SizedBox(height: 38.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: 74.h,
                      //   width: 74.w,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     border:
                      //         Border.all(color: Theme.of(context).primaryColor),
                      //   ),
                      //   // padding: EdgeInsets.all(5.r),
                      //   child: Center(
                      //     child: Image.asset(
                      //       'assets/images/faceBook.png',
                      //       fit: BoxFit.cover,
                      //       height: 55.h,
                      //       width: 55.w,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: 7.w),
                      if (!_isEmail)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEmail = true;
                            });
                          },
                          child: Container(
                            height: 74.h,
                            width: 74.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                            ),
                            padding: EdgeInsets.all(16.r),
                            child: Center(
                              child: Image.asset(
                                'assets/images/mailIcon.png',
                                height: 55.h,
                                width: 55.w,
                              ),
                            ),
                          ),
                        ),
                      if (_isEmail)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEmail = false;
                            });
                          },
                          child: Container(
                            height: 74.h,
                            width: 74.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                            ),
                            padding: EdgeInsets.all(15.r),
                            child: Center(
                              child: Image.asset(
                                'assets/images/phoneIcon.png',
                                fit: BoxFit.cover,
                                height: 55.h,
                                width: 55.w,
                              ),
                            ),
                          ),
                        ),
                      // SizedBox(width: 7.w),
                      // Container(
                      //   height: 74.h,
                      //   width: 74.w,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     border:
                      //         Border.all(color: Theme.of(context).primaryColor),
                      //   ),
                      //   // padding: EdgeInsets.all(5.r),
                      //   child: Center(
                      //       child: Image.asset(
                      //     'assets/images/googleIcon.png',
                      //     fit: BoxFit.cover,
                      //     height: 35.h,
                      //     width: 35.w,
                      //   )),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _mailWidget(bool isMail) {
    return Stack(
      children: [
        TextFormField(
          controller: _mailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Your email',
          ),
          validator: (value) {
            if (isMail) {
              if (value == null || value.isEmpty) {
                return 'This field is mandatory';
              }
            }
            return null;
          },
          onSaved: (value) {},
        ),
      ],
    );
  }

  Widget _passwordWidget() {
    return Stack(
      children: [
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'password',
          ),
        ),
      ],
    );
  }
}


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
               