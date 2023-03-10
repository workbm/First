import 'package:dream_access/helpers/errors/error_2_pop.dart';
import 'package:dream_access/providers/update_profile/update_profile_provider.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/profile/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/general_data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static const routeName = '/editProfile';
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _isLoading = false;
  var _isInit = true;
  var _name = '';
  var _nationality = '';
  var _birthDate = '';
  var _email = '';
  var _phone = '';
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences.getInstance().then((value) {
        _name = value.getString('name')!;
        _email = value.getString('email') ?? '';
        _phone = value.getString('phone') ?? '';
        _nationality = value.getString('nationality') ?? '';
        _birthDate = value.getString('birthDay') ?? '';
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const SizedBox(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop('');
              },
              icon: Icon(
                Icons.close,
                size: 30.r,
                color: Colors.black,
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: GeneralData.width3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ProfileImageWidget(height: 80, width: 80),
                ],
              ),
              const Gap(height: 10),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              const Gap(height: 10),
              Text(
                'Name',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14),
              ),
              const Gap(height: 10),
              Row(
                children: [
                  Text(_name),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _editFct('name', '');
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
              const Gap(height: 10),
              const Divider(
                  indent: 0, endIndent: 0, color: Colors.black, thickness: 0.5),
              const Gap(height: 10),
              Text(
                'Email',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14),
              ),
              const Gap(height: 10),
              Row(
                children: [
                  Text(_email.isNotEmpty ? _email : '_'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _editFct('email', '');
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
              const Gap(height: 10),
              const Divider(
                  indent: 0, endIndent: 0, color: Colors.black, thickness: 0.5),
              const Gap(height: 10),
              Text(
                'Phone number',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14),
              ),
              const Gap(height: 10),
              Row(
                children: [
                  Text(_phone.isNotEmpty ? _phone : '_'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _editFct('phone', '');
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
              const Gap(height: 10),
              const Divider(
                  indent: 0, endIndent: 0, color: Colors.black, thickness: 0.5),
              const Gap(height: 10),
              Text(
                'Date of birth',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14),
              ),
              const Gap(height: 10),
              Row(
                children: [
                  Text(_birthDate.isNotEmpty ? _birthDate : '_'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      print('dialog printed');
                      showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2020),
                        builder: (context, child) => Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary:
                                    GeneralData.primaryColor, // <-- SEE HERE
                                // onPrimary: Colors.redAccent, // <-- SEE HERE
                                // onSurface: Colors.blueAccent, // <-- SEE HERE
                              ),
                            ),
                            child: child!),
                      ).then((value) async {
                        if (value != null) {
                          print('first');
                          try {
                            await context
                                .read<UpdateProfileProvider>()
                                .updateProfileFct(
                                    'birthday', value.toIso8601String())
                                .then((valu) {
                              setState(() {
                                _birthDate = DateFormat('y-M-d').format(value);
                              });
                              print('done');
                            });
                          } catch (err) {
                            print('err');
                            print(err);
                          }
                        }
                      });
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
              const Gap(height: 10),
              const Divider(
                  indent: 0, endIndent: 0, color: Colors.black, thickness: 0.5),
              const Gap(height: 10),
              Text(
                'Nationality',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14),
              ),
              const Gap(height: 10),
              Row(
                children: [
                  Text(_nationality.isNotEmpty ? _nationality : '_'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      _editFct('nationality', '');
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
              const Gap(height: 10),
              const Divider(
                  indent: 0, endIndent: 0, color: Colors.black, thickness: 0.5),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editFct(String mapKey, dynamic value) async {
    final key = GlobalKey<FormState>();
    final controller = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          content: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Update'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is mandatory';
                    }
                    return null;
                  },
                ),
                const Gap(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.red)),
                    ),
                    const SizedBox(width: 20),
                    _isLoading
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: LoadingAnimationWidget.threeArchedCircle(
                                  color: Colors.red, size: 50.r),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {
                              if (!key.currentState!.validate()) {
                                return;
                              }
                              _updateMap(mapKey, controller.text);
                              if (mapKey == 'name') {
                                setState(() {
                                  _name = controller.text;
                                });
                              }
                              if (mapKey == 'email') {
                                setState(() {
                                  _email = controller.text;
                                });
                              }
                              if (mapKey == 'phone') {
                                setState(() {
                                  _phone = controller.text;
                                });
                              }
                              if (mapKey == 'nationality') {
                                setState(() {
                                  _nationality = controller.text;
                                });
                              }
                            },
                            child: const Text('Save'),
                          )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _updateMap(String key, dynamic value) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await context
          .read<UpdateProfileProvider>()
          .updateProfileFct(key, value)
          .then((value) {
        setState(() {
          _isInit = true;
        });
        Navigator.of(context).pop();
      });
    } catch (err) {
      print('err');
      print(err);
      showErrorDialogWith2Pop(context, EditProfile.routeName);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
