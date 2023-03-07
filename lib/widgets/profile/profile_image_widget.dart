import 'dart:convert';
import 'dart:io';

import 'package:dream_access/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? _picture;
  var _imageUrl = '';
  final _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences.getInstance().then((value) {});
    }
    super.didChangeDependencies();
  }

  void _changePic() async {
    try {
      var image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxHeight: 500,
          maxWidth: 500);

      if (image == null) return;
      setState(() {
        _picture = File(image.path);
      });
    } on PlatformException catch (error) {
      print('Failed to pick image: $error');
      rethrow;
    }
  }

  void _sendPic() async {
    // try to not use this part
    if (_picture == null) {
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var header = {
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse(Api.url + Api.uploadImage);
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', _picture!.path))
        ..headers.addAll(header);
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      var responseData = jsonDecode(response.body);
      if (responseData['status'] == true) {
        _imageUrl = responseData['url'];
        prefs.setString('image', _imageUrl);
        print('image added to sharedPreferences');
      }
      print('responseData');
      print(responseData);
    } on Exception catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changePic();
      },
      child: _picture != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(360)),
              child: Image.file(_picture!,
                  fit: BoxFit.cover, height: 65.h, width: 65.w),
            )
          : Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
              ),
              child: const Icon(Icons.person),
            ),
    );
  }
}
