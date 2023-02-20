import 'package:dream_access/providers/acceuil_provider.dart';
import 'package:dream_access/widgets/home/cardetail/car_detail_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key, required this.option});
  final int option;
  @override
  Widget build(BuildContext context) {
    var data = context.watch<AcceuilProvider>();
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
        actions: [
          SizedBox(
              width: 200.w,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15.h),
          child: Column(
            children: (option == 1
                    ? data.latestBestOffers
                    : option == 2
                        ? data.luxuryCars
                        : data.suvCars)
                .map(
                  (e) => CarDetailHomeWidget(car: e),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
