import 'package:dream_access/models/car_search.dart';
import 'package:dream_access/providers/acceuil_provider.dart';
import 'package:dream_access/providers/search_provider.dart';
import 'package:dream_access/screens/profile/profile.dart';
import 'package:dream_access/widgets/home/best_offers_widget.dart';
import 'package:dream_access/widgets/home/cardetail/car_detail_home_widget.dart';
import 'package:dream_access/widgets/home/list_slider_cars_widget.dart';
import 'package:dream_access/widgets/home/search_widget.dart';
import 'package:dream_access/widgets/home/sliding_cars_type_widget.dart';
import 'package:dream_access/widgets/home/wanted_cars.dart';
import 'package:dream_access/widgets/slide_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../widgets/home/divider_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  var _isInit = true;
  var _isLoading = false;
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      context.watch<AcceuilProvider>().acceuilFct().then((_) {
        context.read<AcceuilProvider>().paginationFct(1);
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final _filters = [
    'Filter',
    'Latest',
    'Day Rate (Low to High)',
    'Day Rate (High to Low)',
  ];
  // final _images = [
  //   'https://www.audi.ma/dam/nemo/ma/gamme/1920x1080_A_E-TRON_181025.jpg?imwidth=1323',
  //   'https://www.audi.ma/dam/nemo/models/e-tron/audi-e-tron/my-2022/1920x1080-mtc-xl-16-9/1920x1080-E-TRON_2021_3739.jpg?imwidth=1323',
  //   'https://www.audi.ma/dam/nemo/models/e-tron/audi-e-tron/my-2021/730x730-mtc-1-1-framed/730x730-audi-e-tron-my2021-181020.jpg?imwidth=662',
  // ];
  // final _cars = [
  //   Car(
  //       id: 1,
  //       name: 'Audi Q8 e-tron',
  //       image: [
  //         'https://www.audi.ma/dam/nemo/ma/gamme/1920x1080_A_E-TRON_181025.jpg?imwidth=1323',
  //         'https://www.audi.ma/dam/nemo/models/e-tron/audi-e-tron/my-2022/1920x1080-mtc-xl-16-9/1920x1080-E-TRON_2021_3739.jpg?imwidth=1323',
  //         'https://www.audi.ma/dam/nemo/models/e-tron/audi-e-tron/my-2021/730x730-mtc-1-1-framed/730x730-audi-e-tron-my2021-181020.jpg?imwidth=662',
  //       ],
  //       options: [
  //         '1 day rental available',
  //         'Deposit: AED 90',
  //         'Insurance included',
  //         'Free delivery',
  //       ],
  //       type: 'SUV',
  //       priceByDay: 699,
  //       priceByWeek: 5499,
  //       description:
  //           'The Audi e-tron Quattro is a full-electric luxury SUV, first introduced in 2018. It features a sleek design with a spacious interior, advanced infotainment system, and strong acceleration. The vehicle has a range of around 222 miles and can be charged to 80% within 30 minutes using a fast charger.',
  //       agencyName: 'Golden Agency')
  // ];

  void _showBottomSheet() {
    showBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          height: 600,
        ),
      ),
    );
  }

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

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    CarSearch? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.name ?? ''),
        // subtitle: Text(item?.createdAt?.toString() ?? ''),
        leading: CircleAvatar(
            // this does not work - throws 404 error
            // backgroundImage: NetworkImage(item.avatar ?? ''),
            ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<AcceuilProvider>();
    var data = context.read<AcceuilProvider>();
    var searchListenData = context.watch<SearchProvider>();
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.red, size: 50.r))
            : Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: GeneralData.height,
                          horizontal: GeneralData.width,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              iconSize: 35.r,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SlideRightRoute(page: const Profile()),
                                );
                              },
                              icon: const Icon(
                                Icons.menu,
                              ),
                            ),
                            const Spacer(),
                            // Expanded(
                            //   child: ConstrainedBox(
                            //     constraints: BoxConstraints(maxHeight: 40.h),
                            //     child: TextFormField(
                            //       decoration: InputDecoration(
                            //         labelText: 'Search ...',
                            //         border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(25.r),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                                width: 120.w,
                                child: InkWell(
                                  onTap: () {
                                    _showBottomSheet();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.place,
                                        size: 35.r,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 60.w,
                                        child: const FittedBox(
                                          child: Text(
                                            'Abou Dabi',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(Icons.expand_more, size: 24.r)
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      // SizedBox(height: 5.h),
                      // SizedBox(
                      //   height: 200.h,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: PageView.builder(
                      //     pageSnapping: true,
                      //     itemCount: _images.length,
                      //     onPageChanged: (value) {
                      //       setState(() {
                      //         _index = value;
                      //       });
                      //     },
                      //     itemBuilder: (context, index) => InkWell(
                      //       onTap: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => CarDetail(car: _cars[0]),
                      //           ),
                      //         );
                      //       },
                      //       child: CachedNetworkImage(
                      //         imageUrl: _cars[0].image[0],
                      //         fit: BoxFit.cover,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 5.h),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: _indicators(_index, _images.length),
                      // ),
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: GeneralData.width),
                      //   child: CupertinoSearchTextField(
                      //     controller: _searchController,
                      //     onSuffixTap: () {
                      //       print('object cancel');
                      //       // print(object)
                      //       // setState(() {
                      //       _alphabetSearch = '';

                      //       // });
                      //     },
                      //     onChanged: (value) {
                      //       // _alphabetSearch = value;
                      //       // print('_alphabetSearch:${_alphabetSearch}');
                      //       // print('this $_alphabetSearch');
                      //       print('_alphabetSearch:${_searchController.text}');
                      //       // print('this $_alphabetSearch');
                      //       if (_searchController.text.length > 1) {
                      //         context
                      //             .read<SearchProvider>()
                      //             .searchFct(_searchController.text);
                      //       }
                      //       // if (_alphabetSearch.isEmpty) {
                      //       //   setState(() {});
                      //       // }
                      //     },
                      //   ),
                      // ),

                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     contentPadding: EdgeInsets.symmetric(horizontal: 6.w),
                      //     // enabledBorder: InputBorder.none,
                      //     hintText: 'rechercher',
                      //     border: OutlineInputBorder(
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(7.r)),
                      //     ),
                      //   ),
                      //   controller: _searchController,
                      //   onChanged: (value) {
                      //     _alphabetSearch = value;
                      //     print('_alphabetSearch:${_alphabetSearch}');
                      //     print('this $_alphabetSearch');
                      //     if (_alphabetSearch.length > 1) {
                      //       context
                      //           .read<SearchProvider>()
                      //           .searchFct(_alphabetSearch);
                      //     }
                      //   },
                      // ),

                      const SearchWidget(),
                      searchListenData.isSearchedPressed
                          ? const WantedCars()
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: GeneralData.width,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15.h),
                                      SizedBox(
                                        height: 25.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _filters.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            // height: 40.h,
                                            // width: 120.w,
                                            margin: EdgeInsets.only(right: 5.w),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.r),
                                              border: Border.all(),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  index == 0
                                                      ? Icons.tune
                                                      : index == 1
                                                          ? Icons
                                                              .circle_outlined
                                                          : index == 2
                                                              ? Icons
                                                                  .arrow_upward
                                                              : Icons
                                                                  .arrow_downward,
                                                  size: 20.r,
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  _filters[index],
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                const DividerWidget(),
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: GeneralData.width,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Top Brands',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Text(
                                          'See All',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                ListCarsSliderWidget(
                                  brands: listenData.topBrands,
                                ),
                                SizedBox(height: 15.h),
                                const DividerWidget(),
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: GeneralData.width,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Select a car type',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 4.h),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Text(
                                              'See All',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                SlidingCarsTypeWidget(
                                    carsList: listenData.carType),
                                SizedBox(height: 15.h),
                                BestOffersWidget(
                                  option: 1,
                                  car: listenData.latestBestOffers,
                                ),
                                SizedBox(height: 15.h),
                                BestOffersWidget(
                                  option: 2,
                                  car: listenData.luxuryCars,
                                ),
                                SizedBox(height: 15.h),

                                // SizedBox(height: 15.h),

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
                                BestOffersWidget(
                                    option: 3, car: listenData.suvCars),
                                SizedBox(height: 15.h),

                                // SizedBox(height: 15.h),
                                // CarDetailHomeWidget(car: ),
                                ...listenData.cars.map(
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
      ),
    );
  }
}
