import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/general_data.dart';
import '../../models/car.dart';

class ListCarsSliderWidget extends StatelessWidget {
  const ListCarsSliderWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.isFirst});
  final double height, width;
  final bool isFirst;
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
          price: ''),
      Car(
          id: 0,
          name: 'Ferrari',
          image: ['https://logospng.org/wp-content/uploads/lamborghini.png'],
          type: 'Sedan',
          seat: 4,
          options: [],
          price: ''),
      Car(
          id: 0,
          name: 'Ferrari',
          image: ['https://logospng.org/wp-content/uploads/mini-325x170.png'],
          type: 'Sedan',
          seat: 4,
          options: [],
          price: ''),
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
          price: ''),
      Car(
          id: 0,
          name: 'Ferrari',
          image: ['https://logospng.org/wp-content/uploads/opel-325x170.png'],
          type: 'Sedan',
          seat: 4,
          options: [],
          price: ''),
    ];
    final carType = [
      'assets/images/Buggy.png',
      'assets/images/Classic.png',
      'assets/images/Commerciale.png',
      'assets/images/Convertible.png',
      'assets/images/Coupe.png',
      'assets/images/Grossover.png',
      'assets/images/Low-price.png',
      'assets/images/Luxe.png',
      'assets/images/MONTHLY.png',
      'assets/images/Speciale-Edition.png',
      'assets/images/Suv.png',
      'assets/images/With-Drtive.png',
      'assets/images/Yakhet.png',
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
          itemCount: isFirst ? carBrands.length : carType.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Container(
            height: height,
            width: width,
            margin: EdgeInsets.only(right: 10.w),
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: !isFirst
                ? Image.asset(
                    carType[index],
                    // fit: BoxFit.fill,
                    height: height,
                    width: width,
                  )
                : CachedNetworkImage(
                    imageUrl: carBrands[index].image[0],
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
