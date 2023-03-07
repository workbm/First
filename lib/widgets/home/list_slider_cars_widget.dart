import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/models/brand.dart';
import 'package:dream_access/screens/home/car_by_brand.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/general_data.dart';

class ListCarsSliderWidget extends StatelessWidget {
  const ListCarsSliderWidget({super.key, required this.brands});
  final List<Brand> brands;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GeneralData.width,
      ),
      child: SizedBox(
        height: 120.h,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Column(
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print('brands: $brands');
                  print('carId: ${brands[index].id} ');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CarByBrand(carId: brands[index].id),
                      ));
                  // navigation(context, brands[index].id);
                },
                child: Container(
                  height: 84.h,
                  width: 90.w,
                  margin: EdgeInsets.only(right: 10.w),
                  padding: EdgeInsets.all(13.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 0.1,
                          spreadRadius: 1,
                          color: Color.fromARGB(255, 221, 221, 221)),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: brands[index].logo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Gap(height: 7),
              Container(
                // height: 84.h,
                width: 90.w,
                margin: EdgeInsets.only(right: 10.w),
                // padding: EdgeInsets.all(11.r),
                child: Center(
                  child: Text(
                    brands[index].name.length <= 8
                        ? brands[index].name
                        : '${brands[index].name.substring(0, 8)}..',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigation(BuildContext context, int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarByBrand(carId: id),
        ));
  }
}
