import 'package:dream_access/providers/auth/login/login_provider.dart';
import 'package:dream_access/screens/profile/edit_profile.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../widgets/profile/profile_image_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var list = ['Viewed', 'Wishlist', 'Contacted'];
    var listenData = context.watch<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ));
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: GeneralData.width3),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const ProfileImageWidget(
                  height: 40,
                  width: 40,
                ),
                title: Text(
                  listenData.user.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: listenData.user.email.isNotEmpty
                    ? Text(listenData.user.email)
                    : Text(listenData.user.phoneNumber),
              ),
              const Gap(height: 10),
              const Divider(
                  indent: 0, endIndent: 0, color: Colors.black, thickness: 0.5),
              const Gap(height: 15),
              Text('wish list', style: Theme.of(context).textTheme.headline1),
              const Gap(height: 15),
            ]),
          ),
        ),
      ),
    );
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