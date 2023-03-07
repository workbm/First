import 'package:dream_access/providers/cars_by_brand_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/home/cardetail/car_detail_home_widget.dart';

class CarByBrand extends StatefulWidget {
  const CarByBrand({super.key, required this.carId});
  final int carId;

  @override
  State<CarByBrand> createState() => _CarByBrandState();
}

class _CarByBrandState extends State<CarByBrand> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      context
          .watch<CarsByBrandProvider>()
          .carByBrandFct(widget.carId)
          .then((value) {
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
    var listenData = context.watch<CarsByBrandProvider>();
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
        // actions: [
        //   SizedBox(
        //       width: 200.w,
        //       child: TextFormField(
        //         decoration: const InputDecoration(
        //             border: InputBorder.none,
        //             suffixIcon: Icon(
        //               Icons.search,
        //               color: Colors.black,
        //             )),
        //       )),
        // ],
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.red, size: 50.r))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: Column(
                  children: listenData.cars
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
