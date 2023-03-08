import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/profile/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/general_data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

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
        _nationality = value.getString('nationality')!;
        _birthDate = value.getString('birthDay')!;
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
                Navigator.of(context).pop();
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
              const ProfileImageWidget(height: 60, width: 60),
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
                    onTap: () {},
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
                  const Text(
                    'Edit',
                    style: TextStyle(color: Colors.red),
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
                  const Text(
                    'Edit',
                    style: TextStyle(color: Colors.red),
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
                  const Text(
                    'Edit',
                    style: TextStyle(color: Colors.red),
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
                  const Text(
                    'Edit',
                    style: TextStyle(color: Colors.red),
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

  Future<void> _editFct(String name) async {
    final key = GlobalKey<FormState>();
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(hintText: 'update'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is mandatory';
                  }
                  return null;
                },
              ),
              const Gap(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: const Text('Cancel')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {},
                      child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
