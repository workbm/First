import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/screens/profile/profile.dart';
import 'package:dream_access/widgets/home/best_offers_widget.dart';
import 'package:dream_access/widgets/home/car_between_widget.dart';
import 'package:dream_access/widgets/home/car_detail_home_widget.dart';
import 'package:dream_access/widgets/home/list_slider_cars_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/general_data.dart';
import '../constants/list_cars.dart';
import '../models/car.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  // final _carBrands = [
  //   Car(
  //       id: 0,
  //       name: 'Ferrari',
  //       image: 'https://i.ytimg.com/vi/XZQL_Hrwl54/maxresdefault.jpg',
  //       type: 'Sedan',
  //       seat: 4,
  //       price: ''),
  //   Car(
  //       id: 0,
  //       name: 'Ferrari',
  //       image: 'https://logospng.org/wp-content/uploads/lamborghini.png',
  //       type: 'Sedan',
  //       seat: 4,
  //       price: ''),
  //   Car(
  //       id: 0,
  //       name: 'Ferrari',
  //       image: 'https://logospng.org/wp-content/uploads/mini-325x170.png',
  //       type: 'Sedan',
  //       seat: 4,
  //       price: ''),
  //   Car(
  //       id: 0,
  //       name: 'Ferrari',
  //       image: 'https://logospng.org/wp-content/uploads/audi-325x170.png',
  //       type: 'Sedan',
  //       seat: 4,
  //       price: ''),
  //   Car(
  //       id: 0,
  //       name: 'Ferrari',
  //       image: 'https://logospng.org/wp-content/uploads/volkswagen-325x170.png',
  //       type: 'Sedan',
  //       seat: 4,
  //       price: ''),
  //   Car(
  //       id: 0,
  //       name: 'Ferrari',
  //       image: 'https://logospng.org/wp-content/uploads/opel-325x170.png',
  //       type: 'Sedan',
  //       seat: 4,
  //       price: ''),
  // ];

  final _images = [
    'https://www.audi.ma/dam/nemo/ma/gamme/1920x1080_A_E-TRON_181025.jpg?imwidth=1323',
    'https://www.audi.ma/dam/nemo/models/e-tron/audi-e-tron/my-2022/1920x1080-mtc-xl-16-9/1920x1080-E-TRON_2021_3739.jpg?imwidth=1323',
    'https://www.audi.ma/dam/nemo/models/e-tron/audi-e-tron/my-2021/730x730-mtc-1-1-framed/730x730-audi-e-tron-my2021-181020.jpg?imwidth=662',
  ];
  final _filters = [
    'Filter',
    'Latest',
    'Day Rate\nLow to High',
    'Day Rate\nHigh to Low',
  ];
  // final _cars = [Car(id: 1, name: 'Audi Q8 e-tron', image: image, options: options, type: type, price: price)];

  List<Widget> _indicators(int index, int length) {
    return List<Widget>.generate(
      length,
      (index) => Container(
        height: index != _index ? 10.h : 15.h,
        width: index != _index ? 10.w : 15.w,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 233, 232, 232),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: GeneralData.height,
                  horizontal: GeneralData.width,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: 270.w,
                      child: TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          // hintText: 'Search for car rental',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      iconSize: 35.r,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Profile(),
                            ));
                      },
                      icon: const Icon(
                        Icons.person,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  pageSnapping: true,
                  itemCount: _images.length,
                  onPageChanged: (value) {
                    setState(() {
                      _index = value;
                    });
                  },
                  itemBuilder: (context, index) => CachedNetworkImage(
                    imageUrl: _images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _indicators(_index, _images.length),
              ),
              SizedBox(height: 15.h),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GeneralData.width,
                    ),
                    child: SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _filters.length,
                        itemBuilder: (context, index) => Container(
                          // height: 40.h,
                          width: 130.w,
                          margin: EdgeInsets.only(right: 5.w),
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            border: Border.all(),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                index == 0
                                    ? Icons.tune
                                    : index == 1
                                        ? Icons.circle_outlined
                                        : index == 2
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                              ),
                              Text(_filters[index])
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GeneralData.width,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Top Brands',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  ListCarsSliderWidget(
                    height: 84.h,
                    width: 83.w,
                    isFirst: true,
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GeneralData.width,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'In one click, your car to\n your home',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  ListCarsSliderWidget(
                    height: 84.h,
                    width: 153.w,
                    isFirst: false,
                  ),
                  SizedBox(height: 15.h),
                  BestOffersWidget(
                    option: 1,
                    car: ListCars.sportCars,
                  ),
                  SizedBox(height: 15.h),
                  const CarBetweenWidget(
                    option: 1,
                  ),
                  SizedBox(height: 15.h),
                  BestOffersWidget(
                    option: 2,
                    car: ListCars.luxuryCar,
                  ),
                  SizedBox(height: 15.h),
                  const CarBetweenWidget(
                    option: 2,
                  ),
                  SizedBox(height: 15.h),

                  // ClipRRect(
                  //   borderRadius: const BorderRadius.only(
                  //     topRight: Radius.circular(20),
                  //     topLeft: Radius.circular(20),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         height: 150,
                  //         child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: _images.length,
                  //           itemBuilder: (context, index) => CachedNetworkImage(
                  //             width: size.width,
                  //             imageUrl: _images[index],
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         color: Colors.white,
                  //         height: 200,
                  //         child: Column(
                  //           children: [
                  //             const SizedBox(height: 15),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(horizontal: 8.0),
                  //               child: Column(
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       const Text('Audi e-tron 2022'),
                  //                     ],
                  //                   ),
                  //                   const SizedBox(height: 7),
                  //                   Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       const Text('AED 100 / week'),
                  //                       const Text('AED 2000 / month')
                  //                     ],
                  //                   ),
                  //                   const SizedBox(height: 7),
                  //                   Row(
                  //                     children: const [
                  //                       Icon(Icons.switch_access_shortcut),
                  //                       SizedBox(
                  //                         width: 5,
                  //                       ),
                  //                       Text('1400 km'),
                  //                       Spacer(),
                  //                       Icon(Icons.switch_access_shortcut),
                  //                       SizedBox(
                  //                         width: 5,
                  //                       ),
                  //                       Text('3000 km'),
                  //                     ],
                  //                   ),
                  //                   const SizedBox(height: 7),
                  //                   Row(
                  //                     children: [
                  //                       Container(
                  //                         height: 30,
                  //                         width: 50,
                  //                         padding: const EdgeInsets.symmetric(
                  //                             horizontal: 5, vertical: 2),
                  //                         decoration: BoxDecoration(
                  //                           border: Border.all(),
                  //                           borderRadius:
                  //                               BorderRadius.circular(8),
                  //                         ),
                  //                         child: const Center(
                  //                             child: Text('Sedan')),
                  //                       ),
                  //                       const SizedBox(width: 10),
                  //                       Container(
                  //                         height: 30,
                  //                         width: 50,
                  //                         padding: const EdgeInsets.symmetric(
                  //                             horizontal: 5, vertical: 2),
                  //                         decoration: BoxDecoration(
                  //                           border: Border.all(),
                  //                           borderRadius:
                  //                               BorderRadius.circular(8),
                  //                         ),
                  //                         child: FittedBox(
                  //                           child: Center(
                  //                             child: Row(
                  //                               children: [
                  //                                 const Text('5'),
                  //                                 const SizedBox(width: 13),
                  //                                 const Icon(
                  //                                   Icons.chair,
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             // Spacer(),
                  //             Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: Container(
                  //                     height: 50,
                  //                     color: const Color.fromARGB(
                  //                         255, 192, 219, 233),
                  //                     // width: size.width,
                  //                     child: Image.asset(
                  //                       'assets/images/phone.png',
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     color: const Color.fromARGB(
                  //                         255, 241, 184, 110),
                  //                     // width: size.width,
                  //                     height: 50,
                  //                     child: Image.asset(
                  //                       'assets/images/whatssap.png',
                  //                       // fit: BoxFit.cover,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  BestOffersWidget(option: 3, car: ListCars.suvCars),
                  SizedBox(height: 15.h),
                  const CarBetweenWidget(
                    option: 3,
                  ),
                  SizedBox(height: 15.h),
                  // CarDetailHomeWidget(car: ),
                  ...ListCars.cars.map(
                    (e) => CarDetailHomeWidget(car: e),
                  ),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
