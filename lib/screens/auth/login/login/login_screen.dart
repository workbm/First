import 'package:animate_do/animate_do.dart';
import 'package:dream_access/providers/auth/login/login_phone_provider.dart';
import 'package:dream_access/providers/auth/login/login_provider.dart';
import 'package:dream_access/screens/home/home_page.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/slide_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'forgot_passdart/forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final _phoneController = TextEditingController();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isEmail = true;
  var _isLoading = false;
  var _phoneNumber = '';

  Future<void> _submit() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    if (_isEmail) {
      setState(() {
        _isLoading = true;
      });
      try {
        await context
            .read<LoginProvider>()
            .loginFct(_mailController.text, _passwordController.text)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        });
      } catch (err) {
        print('error');
        print(err);
        _showErrorDialog();
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      _globalKey.currentState!.save();
      _phoneNumber = '';
      _globalKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await context
            .read<LoginPhoneProvider>()
            .loginFct(_phoneNumber, _passwordController.text)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage()),
          );
        });
      } catch (err) {
        print('error');
        print(err);
        _showErrorDialog();
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An error occurred!'),
        content: const Text(
          'Unfortunately, this operation cannot progress, check on the internet or the information you have entered.',
        ),
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
                children: [
                  SizedBox(height: 20.h, width: double.infinity),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  FadeInDown(
                    child: Column(
                      children: [
                        Container(
                          width: 286.w,
                          padding: EdgeInsets.symmetric(horizontal: 13.w),
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
                                      onSaved: (value) {
                                        print('saved');
                                        _phoneNumber = value.phoneNumber!;
                                        print(_phoneNumber);
                                      },
                                      validator: (value) {
                                        if (!_isEmail) {
                                          if (value == null || value.isEmpty) {
                                            return 'This field is mandatory';
                                          }
                                        }
                                        return null;
                                      },
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
                              : _mailWidget(),
                        ),
                        const Gap(height: 15),
                        Container(
                          width: 286.w,
                          padding: EdgeInsets.symmetric(horizontal: 13.w),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 189, 188, 188),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: _passwordWidget(),
                        ),
                        const Gap(height: 15),
                        GestureDetector(
                          onTap: () {
                            _forgotPassword();
                          },
                          child: const Text(
                            'Forgot your password?',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
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
                  // SizedBox(height: 38.h),
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
                  //       child: const Center(
                  //           child: Text(
                  //         'OR',
                  //         style: TextStyle(color: Colors.white),
                  //       )),
                  //     ),
                  //     Expanded(
                  //         child: Divider(
                  //       thickness: 1.h,
                  //       color: Colors.black,
                  //     )),
                  //   ],
                  // ),

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
                      // Container(
                      //   height: 39.h,
                      //   width: 39.w,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     border:
                      //         Border.all(color: Theme.of(context).primaryColor),
                      //   ),
                      //   padding: EdgeInsets.all(5.r),
                      //   child: const Center(
                      //       child: Text(
                      //     'OR',
                      //     style: TextStyle(color: Colors.white),
                      //   )),
                      // ),
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

  void _forgotPassword() {
    Navigator.push(
      context,
      SlideRightRoute(page: const ForgotPassword()),
    );
  }

  Widget _mailWidget() {
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
            if (_isEmail) {
              if (value == null || value.isEmpty) {
                return 'This field is mandatory';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _passwordWidget() {
    return Stack(
      children: [
        TextFormField(
          obscureText: true,
          controller: _passwordController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'password',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is mandatory';
            }
            return null;
          },
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
               