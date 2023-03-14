import 'package:dream_access/providers/auth/login/login_provider.dart';
import 'package:dream_access/providers/logout_provider.dart';
import 'package:dream_access/providers/wishlist/get_wishlist_provider.dart';
import 'package:dream_access/screens/home/home_page.dart';
import 'package:dream_access/screens/profile/edit_profile.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/wishlist/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/general_data.dart';
import '../../widgets/profile/profile_information_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _isLoading = false;
  var _isInit = true;
  var _wishlistLoading = false;
  var _token = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      SharedPreferences.getInstance().then((value) {
        if (value.containsKey('token')) {
          setState(() {
            _token = true;
            _wishlistLoading = true;
          });
          context.read<GetWishlistProvider>().getWishlistFct().then((value) {
            setState(() {
              _wishlistLoading = false;
            });
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var list = ['Viewed', 'Wishlist', 'Contacted'];
    var listenData = context.watch<LoginProvider>();
    var listenDataWishlist = context.watch<GetWishlistProvider>();
    return Scaffold(
      bottomNavigationBar: _token
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 8.h),
              child: _isLoading
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 192, 147, 147)),
                      onPressed: () {},
                      child: const Text('Sign out'),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GeneralData.primaryColor),
                      onPressed: () {
                        _signOutFct();
                      },
                      child: const Text('Sign out'),
                    ),
            )
          : const SizedBox(),
      appBar: AppBar(
          leading: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: GeneralData.width),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          !_token
              ? Icon(Icons.person, size: 40)
              : const ProfileInformationWidget(),
          const Gap(height: 10),
          const Divider(
              indent: 0, endIndent: 0, color: Colors.black, thickness: 0.5),
          const Gap(height: 15),
          Text('wish list', style: Theme.of(context).textTheme.headline1),
          const Gap(height: 10),
          _token
              ? _wishlistLoading
                  ? Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: Colors.red, size: 50.r),
                    )
                  : Expanded(
                      child: WishlistWidget(
                          cars: listenDataWishlist.cars, option: 1))
              : SizedBox(
                  height: 250.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Log in or sign up to have a profile and save your wish list',
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
        ]),
      ),
    );
  }

  Future<void> _signOutFct() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var prefs = await SharedPreferences.getInstance();
      prefs.clear().then((value) {
        context.read<LogoutProvider>().logoutProvider();
        Navigator.pushNamed(context, MyHomePage.routeName);
      });
    } catch (err) {
      print('err');
      print(err);
    }
    setState(() {
      _isLoading = false;
    });
  }
}


// SizedBox(
//                 height: 50.h,
//                 width: double.infinity,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: list.length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) => Container(
//                     height: 50.h,
//                     width: 110.w,
//                     margin: index == 1
//                         ? EdgeInsets.symmetric(horizontal: 10.w)
//                         : const EdgeInsets.all(0),
//                     decoration: BoxDecoration(
//                       border: Border.all(),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Center(
//                       child: Text(list[index]),
//                     ),
//                   ),
//                 ),
//               )