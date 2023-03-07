import 'package:animate_do/animate_do.dart';
import 'package:dream_access/providers/auth/signup/signup_provider.dart';
import 'package:dream_access/screens/home/home_page.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final _globalKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  var _isLoading = false;
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                  const Gap(height: 100),
                  Text(
                    'Enter Password',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 33.h),
                  FadeInDown(
                    child: Column(
                      children: [
                        Container(
                          width: 286.w,
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 189, 188, 188),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'password',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'This field is mandatory';
                                      }
                                      if (value.length < 6) {
                                        return 'This password is short';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Gap(height: 15),
                        Container(
                          width: 286.w,
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 189, 188, 188),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  TextFormField(
                                    controller: _confirmPassword,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'confirm your password',
                                    ),
                                    validator: (value) {
                                      if (_passwordController.text != value) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                  Gap(height: 38.h),
                ],
              ),
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
          .read<SignUpProvider>()
          .signupFct(_passwordController.text)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      });
    } catch (err) {
      print('err');
      print(err);
      _showErrorDialog();
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
        content: const Text(
          'Unfortunately, this operation cannot progress, check on the internet or try again later.',
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
}
