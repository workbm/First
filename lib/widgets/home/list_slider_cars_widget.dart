import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/models/brand.dart';
import 'package:dream_access/screens/home/car_by_brand.dart';
import 'package:dream_access/widgets/slide_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/general_data.dart';
import '../../models/car.dart';

class ListCarsSliderWidget extends StatelessWidget {
  const ListCarsSliderWidget({super.key, required this.brands});
  final List<Brand> brands;
  @override
  Widget build(BuildContext context) {
    final carBrands = [
      Car(
          id: 0,
          name: 'Ferrari',
          image: ['https://i.ytimg.com/vi/XZQL_Hrwl54/maxresdefault.jpg'],
          type: 'Sedan',
          seat: 4,
          options: [],
          // price: '',
          agencyName: 'Fast Cars Agency'),
      Car(
          id: 0,
          name: 'Ferrari',
          image: ['https://logospng.org/wp-content/uploads/lamborghini.png'],
          type: 'Sedan',
          seat: 4,
          options: [],
          // price: '',
          agencyName: 'Golden Agency'),
      Car(
          id: 0,
          name: 'Ferrari',
          image: ['https://logospng.org/wp-content/uploads/mini-325x170.png'],
          type: 'Sedan',
          seat: 4,
          options: [],
          // price: '',
          agencyName: 'Ayman Agency'),
      // Car(
      //   id: 0,
      //   name: 'Ferrari',
      //   image: 'https://logospng.org/wp-content/uploads/audi-325x170.png',
      //   type: 'Sedan',
      //   seat: 4,
      // ),
      Car(
          id: 0,
          name: 'Ferrari',
          image: [
            'https://logospng.org/wp-content/uploads/volkswagen-325x170.png'
          ],
          type: 'Sedan',
          seat: 4,
          options: [],
          // price: '',
          agencyName: 'Khalid Agency'),
      Car(
          id: 0,
          name: 'Ferrari',
          image: ['https://logospng.org/wp-content/uploads/opel-325x170.png'],
          type: 'Sedan',
          seat: 4,
          options: [],
          // price: '',
          agencyName: 'Ritaj Agency'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GeneralData.width,
      ),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              navigation(context, brands[index].id);
            },
            child: Container(
              height: 84.h,
              width: 84.w,
              margin: EdgeInsets.only(right: 17.w),
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: brands[index].logo,
                fit: BoxFit.contain,
              ),
            ),
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
