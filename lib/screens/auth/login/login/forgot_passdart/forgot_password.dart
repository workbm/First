import 'package:dream_access/providers/password/send_mail_provider.dart';
import 'package:dream_access/screens/auth/login/login/forgot_passdart/verify.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/slide_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _globalKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
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
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is mandatory';
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
          .emailVerificationFct(_emailController.text)
          .then((value) {
        Navigator.push(context, SlideRightRoute(page: const Verify()));
      });
    } on Exception catch (error) {
      var errorMessage = 'Unfortunately, the operation failed';
      if (error.toString().contains('The user does not exist')) {
        errorMessage = 'The user does not exist';
      }
      _showErrorDialog(errorMessage);
    } catch (err) {
      const errorMessage = 'Unfortunately, the operation failed';
      _showErrorDialog(errorMessage);
      print('err');
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
  }

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
}
