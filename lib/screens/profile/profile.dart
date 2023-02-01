import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/screens/about_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: GeneralData.width3),
          child: Column(
            children: [
              SizedBox(height: 25.h),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 65.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                ),
                title: const Text(
                  'Karim Bennis',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: const Text('+971  4 224 5555'),
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('About us'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUs(),
                      ));
                },
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Send us your feedback'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('More'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
              const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Logout'),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
              ),
              const Divider(
                indent: 0,
                endIndent: 0,
                color: Colors.black,
                thickness: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
