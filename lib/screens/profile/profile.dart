import 'package:dream_access/providers/auth/login/login_provider.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/profile/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var list = ['Viewed', 'Wishlist', 'Contacted'];
    var listenData = context.watch<LoginProvider>();
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
          child: Column(children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: const ProfileImageWidget(),
              title: Text(
                listenData.user.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: listenData.user.email.isNotEmpty
                  ? Text(listenData.user.email)
                  : Text(listenData.user.phoneNumber),
            ),
            const Gap(height: 20),
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                  height: 50.h,
                  width: 110.w,
                  margin: index == 1
                      ? EdgeInsets.symmetric(horizontal: 10.w)
                      : const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(list[index]),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
