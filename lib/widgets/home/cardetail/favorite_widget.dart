import 'package:dream_access/helpers/errors/error_dialog.dart';
import 'package:dream_access/providers/wishlist/save_wishlist_provider.dart';
import 'package:dream_access/screens/auth/login/login/auth_screen.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/general_data.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key, required this.carID});
  final int carID;
  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  var _isFavorite = false;
  var _isLoading = false;

  Future<void> _favoriteFct() async {
    print('isFav pressed');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      setState(() {
        _isLoading = false;
      });
      try {
        context
            .read<SaveWishlistProvider>()
            .saveWishlistFct(widget.carID)
            .then((value) {
          setState(() {
            _isLoading = false;
            _isFavorite = !_isFavorite;
          });
        });
      } catch (err) {
        print('error');
        print(err);
        showErrorDialogHelper(context);
        print('err exist in fav');
      }
    } else {
      _showLogin();
    }
  }

  void _showLogin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Register or log in first'),
            const Gap(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: GeneralData.primaryColor),
                    )),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GeneralData.primaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, AuthScreen.routeName);
                    },
                    child: const Text('Login')),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      margin: const EdgeInsets.only(top: 7, left: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: GeneralData.favoriteButton),
      child: Center(
        child: _isLoading
            ? SizedBox(
                height: 20.r,
                width: 20.r,
                child: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.red, size: 19.r),
                ),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _favoriteFct();
                },
                icon: _isFavorite
                    ? Icon(
                        Icons.favorite,
                        color: GeneralData.primaryColor,
                        size: 20.r,
                      )
                    : Icon(
                        Icons.favorite_border,
                        size: 20.r,
                      )),
      ),
    );
  }
}
