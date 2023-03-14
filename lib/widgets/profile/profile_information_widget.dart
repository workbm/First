import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_image_widget.dart';

class ProfileInformationWidget extends StatefulWidget {
  const ProfileInformationWidget({super.key});

  @override
  State<ProfileInformationWidget> createState() =>
      _ProfileInformationWidgetState();
}

class _ProfileInformationWidgetState extends State<ProfileInformationWidget> {
  var _isInit = true;
  var _isLoading = false;
  var _name = '';
  var _email = '';
  var _phone = '';
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences.getInstance().then((value) {
        _name = value.getString('name') ?? '';
        _email = value.getString('email') ?? '';
        _phone = value.getString('phone') ?? '';
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
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: FittedBox(
        fit: BoxFit.cover,
        child: ProfileImageWidget(
          height: 28,
          width: 28,
        ),
      ),
      title: Text(
        _name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(_email),
    );
  }
}
