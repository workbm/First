import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/api.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/providers/update_profile/update_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget(
      {super.key, required this.height, required this.width});
  final int height, width;

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? _picture;
  var _imageUrl = '';
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      SharedPreferences.getInstance().then((value) {
        _imageUrl = value.getString('image') ?? GeneralData.profileImage;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _changePic() async {
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

  Future<void> _sendPic() async {
    // try to not use this part
    if (_picture == null) {
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final name = prefs.getString('name');
      var header = {
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse(Api.url + Api.uploadImage);
      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('image', _picture!.path))
        ..fields['name'] = name!
        ..headers.addAll(header);
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      var responseData = jsonDecode(response.body);
      print('responseData');
      print(responseData);
      // if (responseData['status'] == true) {
      _imageUrl = responseData['image'];
      prefs.setString('image', _imageUrl);
      print('image added to sharedPreferences');
      // }
      print('responseData');
      print(responseData);
    } catch (err) {
      print('err');
      print(err);
      rethrow;
    }
  }

  Future<void> _uploadPic() async {
    try {
      await _changePic().then((_) {
        _sendPic().then((_) {
          context.read<UpdateImageProvider>().imageFct(_imageUrl);
        });
      });
    } catch (error) {
      print('error');
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<UpdateImageProvider>();
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: () {
              _uploadPic();
            },
            child: SizedBox(
              height: widget.height.h,
              width: widget.width.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: listenData.imageUrl.isNotEmpty
                      ? listenData.imageUrl
                      : _imageUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
