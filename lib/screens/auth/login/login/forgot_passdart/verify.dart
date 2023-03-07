import 'package:animate_do/animate_do.dart';
import 'package:dream_access/providers/password/send_mail_provider.dart';
import 'package:dream_access/screens/auth/login/login/forgot_passdart/update_password.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final _globalKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  void _submit() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    if (_controller.text != context.read<SendEmailProvider>().code.toString()) {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UpdatePassword(),
        ));
  }

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
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Container(
            height: size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bmBackground.png"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                children: [
                  const Gap(height: 100),
                  Text(
                    'Verify',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 33.h),
                  const Text(
                    'Please enter the 6-digit code \nsent to your email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 33.h),
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
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              TextFormField(
                                controller: _controller,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: 'Enter the code',
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is mandatory';
                                  }
                                  return null;
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  ElevatedButton(
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
      ),
    );
  }
}
