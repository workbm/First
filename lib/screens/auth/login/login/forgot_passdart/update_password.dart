import 'package:dream_access/providers/password/send_mail_provider.dart';
import 'package:dream_access/screens/auth/login/login/login_screen.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/slide_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _globalKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
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
      body: Form(
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
                const Gap(height: 103),
                Image.asset(
                  'assets/images/logo.png',
                  height: 91.h,
                  width: 85.w,
                ),
                SizedBox(
                  height: 61.h,
                ),
                Column(
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
                      child: Stack(
                        children: [
                          TextFormField(
                            controller: _controller,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter the new password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is mandatory';
                              }
                              if (value.length < 6) {
                                return 'The password is too short';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
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
                      child: Stack(
                        children: [
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm your password',
                            ),
                            validator: (value) {
                              if (value != _controller.text) {
                                return 'The passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
              ],
            ),
          ),
        ),
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
          .read<SendEmailProvider>()
          .updatePasswordFct(_controller.text)
          .then((value) {
        Navigator.push(context, SlideRightRoute(page: const LoginScreen()));
      });
    } catch (err) {
      _showErrorDialog();
      print('err');
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An error occurred!'),
        content: const Text('Unfortunately, the operation failed'),
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
}
