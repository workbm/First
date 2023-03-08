import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateImageProvider with ChangeNotifier {
  var _imageUrl = '';
  String get imageUrl => _imageUrl;
  var _imageHasChanged = false;
  bool get imageHasChanged => _imageHasChanged;

  void changeImageNotifierFct(bool isTrue) {
    isTrue ? _imageHasChanged = true : _imageHasChanged = false;
    notifyListeners();
  }

  void imageFct(String imageUrl) async {
    _imageUrl = imageUrl;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('image', _imageUrl);
    notifyListeners();
  }
}
