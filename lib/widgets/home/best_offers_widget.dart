import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/screens/car_detail/car_detail.dart';
import 'package:dream_access/screens/see_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/car.dart';

class BestOffersWidget extends StatelessWidget {
  const BestOffersWidget(
      {super.key,
      required this.car,
      required this.option,
      required this.title});
  final List<Car> car;
  final int option;
  final String title;
  @override
  Widget build(BuildContext context) {
    // const titles = [
    //   'Our best offers',
    //   'Luxury cars!',
    //   'Suv cars!',
    // ];
    // const sportCarImages = [
    //   'https://ag-spots-2018.o.auroraobjects.eu/2018/06/17/ferrari-laferrari-c106217062018184712_1.jpg',
    //   'https://cdn.motor1.com/images/mgl/B43Am/s4/2017-lamborghini-aventador-s.jpg',
    //   'https://www.breezcar.com/img-c/pageimg/2981_W750.jpg',
    // ];

    const luxuryCarImages = [
      'https://static.tcimg.net/vehicles/oem/b1a1f917370c928c/2023-Cadillac-CT4-V.jpg?fit=crop&h=514.9464668094218&w=720',
      'https://www.biegowelove.pl/wp-content/uploads/2021/06/2021-Mercedes-Maybach-Klasa-S-S680-Recenzja-1024x682.jpg',
      'https://static.tcimg.net/vehicles/oem/25d60abf704dbe95/2023-BMW-7_Series.jpg?fit=crop&h=514.9464668094218&w=720',
    ];
    const suvcarImages = [
      'https://guide.autoscout24.ch/wp-content/uploads/2022/07/suv_2022_volvo-xc40-recharge_autoscout24-6-768x432.jpg',
      'https://i.gaw.to/content/photos/37/11/371104_Le_Mercedes-Maybach_GLS_sera_le_vehicule_le_plus_cher_produit_en_Amerique.jpg',
      'https://media.ed.edmunds-media.com/bentley/bentayga/2018/oem/2018_bentley_bentayga_4dr-suv_mulliner_fq_oem_1_815.jpg',
    ];

    // const sportCarDescription = [
    //   [
    //     'Ferrari Laferrari',
    //     'AED 2699 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 5000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    //   [
    //     'Lamborghini Aventador',
    //     'AED 1599 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 3000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    //   [
    //     'McLaren P1',
    //     'AED 1399 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 5000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    // ];
    // const luxuryCarDescription = [
    //   [
    //     'Cadillac CT4 V',
    //     'AED 2699 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 5000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    //   [
    //     'Mercedes Maybach S680',
    //     'AED 1599 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 3000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    //   [
    //     'BMW 7 Series',
    //     'AED 1399 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 5000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    // ];
    // const suvCarDescription = [
    //   [
    //     'Volvo xc40',
    //     'AED 2699 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 5000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    //   [
    //     'Mercedes Maybach GLS',
    //     'AED 1599 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 3000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    //   [
    //     'Bentley Bentayga',
    //     'AED 1399 / day 250 km',
    //     '1 day rental available',
    //     'Deposit: AED 5000',
    //     'Insurance included',
    //     'Free delivery',
    //   ],
    // ];

    final carTypes = option == 1
        ? 1
        : option == 2
            ? 2
            : 3;
    return Container(
      // height: 270.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
          color: (option == 1 || option == 3) ? Colors.black : Colors.white),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: GeneralData.width),
            child: Row(
              children: [
                Text(
                  // option == 1
                  //     ? titles[0]
                  //     : option == 2
                  //         ? titles[1]
                  //         : titles[2],
                  title,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: (option == 1 || option == 3)
                          ? Colors.white
                          : Colors.black),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeeAllScreen(option: carTypes),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'See All',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: (option == 1 || option == 3)
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.only(left: GeneralData.width),
            height: 153.h,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: car.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarDetail(car: car[index]),
                    ),
                  );
                },
                child: Container(
                  height: 153.h,
                  width: 320.w,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: GeneralData.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        // color: Colors.amber,
                        padding: EdgeInsets.symmetric(
                          // horizontal: 4.w,
                          vertical: 2.h,
                        ),
                        height: 153.h,
                        width: 125.w,
                        // padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: car[index].image[0],
                            // option == 1
                            //     ? car[index].image[0]
                            //     : option == 2
                            //         ? luxuryCarImages[index]
                            //         : suvcarImages[index],
                            //option == 1
                            //     ? sportCarImages[index]
                            //     : option == 2
                            //         ? luxuryCarImages[index]
                            //         : suvcarImages[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 5.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              // height: 50.h,
                              width: 150.w,
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.green)),
                              child: AutoSizeText(
                                car[index].name,
                                style: Theme.of(context).textTheme.headline1,
                                wrapWords: false,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            SizedBox(
                              // width: 140.w,
                              child: Row(
                                children: [
                                  const Text(
                                    'AED ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 10),
                                  ),
                                  Text(
                                    car[index].priceByDay.toString(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 10),
                                  ),
                                  const Text(
                                    '/day',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  SizedBox(width: 5.w),
                                  const Text(
                                    'AED ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 10),
                                  ),
                                  Text(
                                    car[index].priceByWeek.toString(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 10),
                                  ),
                                  const Text(
                                    '/week',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              car[index].agencyName,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            // SizedBox(height: 7.h),
                            // Row(
                            //   children: [
                            //     SizedBox(width: 20.w),
                            //     CircleAvatar(
                            //       radius: 3.r,
                            //       backgroundColor: Colors.black,
                            //     ),
                            //     SizedBox(width: 5.w),
                            //     Text(
                            //       option == 1
                            //           ? car[index].options[0]
                            //           : option == 2
                            //               ? car[index].options[0]
                            //               : car[index].options[0],
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     SizedBox(width: 20.w),
                            //     CircleAvatar(
                            //       radius: 3.r,
                            //       backgroundColor: Colors.black,
                            //     ),
                            //     SizedBox(width: 5.w),
                            //     Text(
                            //       option == 1
                            //           ? car[index].options[1]
                            //           : option == 2
                            //               ? car[index].options[1]
                            //               : car[index].options[1],
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     SizedBox(width: 20.w),
                            //     CircleAvatar(
                            //       radius: 3.r,
                            //       backgroundColor: Colors.black,
                            //     ),
                            //     SizedBox(width: 5.w),
                            //     Text(
                            //       option == 1
                            //           ? car[index].options[2]
                            //           : option == 2
                            //               ? car[index].options[2]
                            //               : car[index].options[2],
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: [
                            //     SizedBox(width: 20.w),
                            //     CircleAvatar(
                            //       radius: 3.r,
                            //       backgroundColor: Colors.black,
                            //     ),
                            //     SizedBox(width: 5.w),
                            //     Text(
                            //       option == 1
                            //           ? car[index].options[3]
                            //           : option == 2
                            //               ? car[index].options[3]
                            //               : car[index].options[3],
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          )
        ],
      ),
    );
  }
}
