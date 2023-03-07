import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/providers/pagination_provider.dart';
import 'package:dream_access/screens/home/home_page.dart';
import 'package:dream_access/slides/left_slide.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../models/car.dart';
import '../../widgets/home/cardetail/car_detail_home_widget.dart';

class CarDetailWithId extends StatefulWidget {
  const CarDetailWithId({super.key, required this.name});
  final String name;

  @override
  State<CarDetailWithId> createState() => _CarDetailWithIdState();
}

class _CarDetailWithIdState extends State<CarDetailWithId> {
  final PagingController<int, Car> _pagingController =
      PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      await context
          .read<PaginationProvider>()
          .searchByKeywordFct(pageKey, 'BMW')
          .then(
        (_) {
          if (context.read<PaginationProvider>().lastPage == pageKey) {
            _pagingController
                .appendLastPage(context.read<PaginationProvider>().cars);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(
                context.read<PaginationProvider>().cars, nextPageKey);
          }
        },
      );
    } catch (err) {
      print('err');
      print(err);
      _pagingController.error = err;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: GeneralData.width),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, SlideLeftRoute(page: const MyHomePage()));
                    },
                    icon: const Icon(Icons.arrow_back_ios))
              ],
            ),
          ),
          const Gap(height: 10),
          Expanded(
            child: PagedListView<int, Car>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Car>(
                itemBuilder: (context, item, index) =>
                    CarDetailHomeWidget(car: item),
              ),
            ),
          ),
        ],
      )),
    );
  }
}





         // ? Center(
            //     child: LoadingAnimationWidget.threeArchedCircle(
            //         color: Colors.red, size: 50.r))
            // : SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.symmetric(
            //             horizontal: GeneralData.width2,
            //           ),
            //           child: Column(
            //             children: [
            //               Stack(
            //                 children: [
            //                   SizedBox(
            //                     width: double.infinity,
            //                     height: 250.h,
            //                   ),
            //                   SizedBox(
            //                     width: double.infinity,
            //                     height: 250.h,
            //                     child: ClipRRect(
            //                       borderRadius: BorderRadius.only(
            //                         bottomLeft: Radius.circular(10.r),
            //                         bottomRight: Radius.circular(10.r),
            //                       ),
            //                       child: CachedNetworkImage(
            //                         imageUrl: listenData.car.image[0],
            //                         fit: BoxFit.cover,
            //                       ),
            //                     ),
            //                   ),
            //                   IconButton(
            //                     padding: const EdgeInsets.all(10),
            //                     onPressed: () {
            //                       Navigator.of(context).pop();
            //                     },
            //                     icon: const Icon(
            //                       Icons.arrow_back_ios,
            //                     ),
            //                   )
            //                 ],
            //               ),
            //               const Gap(height: 10),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   InkWell(
            //                     onTap: () {
            //                       _phone(listenData.car.id);
            //                     },
            //                     child: CircleAvatar(
            //                       radius: 36.r,
            //                       backgroundColor:
            //                           Theme.of(context).primaryColor,
            //                       child:
            //                           Image.asset('assets/images/appel1.png'),
            //                     ),
            //                   ),
            //                   InkWell(
            //                     onTap: () {
            //                       _openWhatsApp(listenData.car.id);
            //                     },
            //                     child: CircleAvatar(
            //                       radius: 36.r,
            //                       backgroundColor: const Color(0xff8BC442),
            //                       child:
            //                           Image.asset('assets/images/watssap.png'),
            //                     ),
            //                   ),
            //                   InkWell(
            //                     onTap: () {
            //                       _openMail(
            //                           listenData.car.id,
            //                           listenData.car.agencyName,
            //                           listenData.car.name);
            //                     },
            //                     child: CircleAvatar(
            //                       radius: 36.r,
            //                       backgroundColor: Colors.black,
            //                       child: Image.asset('assets/images/mail1.png'),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               const Gap(height: 10),
            //               Container(
            //                 decoration: BoxDecoration(
            //                     border:
            //                         Border.all(color: GeneralData.borderColor),
            //                     borderRadius: BorderRadius.circular(15.r)),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                         height: 121.h,
            //                         width: 114.w,
            //                         padding:
            //                             EdgeInsets.fromLTRB(5.w, 3.r, 3.r, 3.r),
            //                         child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(15.r),
            //                           child: GestureDetector(
            //                             onTap: () {
            //                               _navigateToAgency(
            //                                   listenData.car.agence[0].id);
            //                             },
            //                             child: CachedNetworkImage(
            //                               imageUrl: listenData.car.agencyLogo,
            //                             ),
            //                           ),
            //                         )),
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         SizedBox(
            //                           width: 160.w,
            //                           // height: 50.h,
            //                           child: AutoSizeText(
            //                             listenData.car.name,
            //                             style: Theme.of(context)
            //                                 .textTheme
            //                                 .headline1,
            //                           ),
            //                         ),
            //                         SizedBox(height: 5.h),
            //                         Row(
            //                           children: [
            //                             Icon(Icons.done, size: 20.r),
            //                             const Text('Minimum 2 days rental'),
            //                           ],
            //                         ),
            //                         Row(
            //                           children: [
            //                             Icon(Icons.done, size: 20.r),
            //                             const Text('5%  VAT applicable'),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               // SizedBox(
            //               //   height: 15.h,
            //               // ),

            //               // SizedBox(height: 15.h),
            //               // VectorsWidget(car: listenData.car),

            //               SizedBox(height: 15.h),

            //               Container(
            //                 height: 50.h,
            //                 decoration: BoxDecoration(
            //                     border:
            //                         Border.all(color: GeneralData.borderColor),
            //                     borderRadius: BorderRadius.circular(25.r)),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   children: [
            //                     Text(
            //                       'AED ${listenData.car.priceByDay.toString()}/day',
            //                     ),
            //                     VerticalDivider(
            //                       color: Colors.red,
            //                       indent: 10.h,
            //                       endIndent: 10.h,
            //                     ),
            //                     Text(
            //                       'AED ${listenData.car.priceByWeek.toString()}/week',
            //                     ),
            //                     VerticalDivider(
            //                       color: Colors.red,
            //                       indent: 10.h,
            //                       endIndent: 10.h,
            //                     ),
            //                     Text(
            //                       'AED ${listenData.car.priceByMonth.toString()}/month',
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 15.h),
            //               SpecContainerWidget(
            //                 isWidth: false,
            //                 widget: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       'Rental includes',
            //                       style: Theme.of(context).textTheme.headline1,
            //                     ),
            //                     Padding(
            //                       padding:
            //                           EdgeInsets.symmetric(horizontal: 18.w),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: const [
            //                               Text('Insurance'),
            //                               Spacer(),
            //                               Text('Basic comprehensive'),
            //                             ],
            //                           ),
            //                           SizedBox(height: 15.h),
            //                           const Text('Extras'),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 15.h),
            //                     const Divider(indent: 0, endIndent: 0),
            //                     SizedBox(height: 15.h),
            //                     Text(
            //                       'Car color',
            //                       style: Theme.of(context).textTheme.headline1,
            //                     ),
            //                     Padding(
            //                       padding:
            //                           EdgeInsets.symmetric(horizontal: 18.w),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: [
            //                               const Text('Exterior'),
            //                               const Spacer(),
            //                               ...listenData.car.exterColor
            //                                   .map(
            //                                     (e) => Container(
            //                                       margin: EdgeInsets.only(
            //                                           left: 3.w),
            //                                       height: 13.h,
            //                                       width: 13.w,
            //                                       decoration: BoxDecoration(
            //                                           border: Border.all(
            //                                               color: Colors
            //                                                   .grey.shade400,
            //                                               width: 0.5),
            //                                           color: Color((int.parse(
            //                                               e.value)))),
            //                                     ),
            //                                   )
            //                                   .toList(),
            //                               // Container(
            //                               //   height: 13.h,
            //                               //   width: 13.w,
            //                               //   decoration: BoxDecoration(
            //                               //       color: Color((listenData.car
            //                               //           .exterColor[1]) as int)),
            //                               // ),
            //                             ],
            //                           ),
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: [
            //                               const Text('Interior'),
            //                               const Spacer(),
            //                               ...listenData.car.interColor
            //                                   .map(
            //                                     (e) => Container(
            //                                       margin: EdgeInsets.only(
            //                                           left: 3.w),
            //                                       height: 13.h,
            //                                       width: 13.w,
            //                                       decoration: BoxDecoration(
            //                                           border: Border.all(
            //                                               color: Colors
            //                                                   .grey.shade400,
            //                                               width: 0.5),
            //                                           color: Color((int.parse(
            //                                               e.value)))),
            //                                     ),
            //                                   )
            //                                   .toList(),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     const Divider(indent: 0, endIndent: 0),
            //                     const Gap(height: 15),
            //                     Text(
            //                       'Car specs',
            //                       style: Theme.of(context).textTheme.headline1,
            //                     ),
            //                     const Gap(height: 15),
            //                     GridView(
            //                       shrinkWrap: true,
            //                       physics: const NeverScrollableScrollPhysics(),
            //                       gridDelegate:
            //                           const SliverGridDelegateWithFixedCrossAxisCount(
            //                               crossAxisCount: 2,
            //                               childAspectRatio: 5),
            //                       children: [
            //                         Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 'assets/images/svg/transmission.svg',
            //                                 height: 20.h,
            //                                 width: 20.w),
            //                             SizedBox(width: 5.w),
            //                             SizedBox(
            //                                 width: 140.w,
            //                                 child: listenData
            //                                             .car.transmissionType ==
            //                                         1
            //                                     ? const AutoSizeText(
            //                                         'Transmission: AUTO',
            //                                         maxLines: 1,
            //                                         maxFontSize: 11,
            //                                         minFontSize: 10,
            //                                       )
            //                                     : const AutoSizeText(
            //                                         'Transmission: MANUAL',
            //                                         maxLines: 1,
            //                                         maxFontSize: 11,
            //                                         minFontSize: 10,
            //                                       )),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 'assets/images/svg/car.svg',
            //                                 color: Colors.black,
            //                                 height: 20.h,
            //                                 width: 20.w),
            //                             SizedBox(width: 5.w),
            //                             SizedBox(
            //                               child: SizedBox(
            //                                   width: 120.w,
            //                                   child: AutoSizeText(
            //                                     listenData.car.type,
            //                                     maxFontSize: 11,
            //                                     minFontSize: 10,
            //                                   )),
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 'assets/images/svg/doors.svg',
            //                                 color: Colors.black,
            //                                 height: 20.h,
            //                                 width: 20.w),
            //                             SizedBox(width: 5.w),
            //                             SizedBox(
            //                                 width: 140.w,
            //                                 child: AutoSizeText(
            //                                   '${listenData.car.doors} doors',
            //                                   maxFontSize: 11,
            //                                   minFontSize: 10,
            //                                 )),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 'assets/images/svg/seats.svg',
            //                                 color: Colors.black,
            //                                 height: 20.h,
            //                                 width: 20.w),
            //                             SizedBox(width: 5.w),
            //                             Text('${listenData.car.seat} seats'),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 'assets/images/svg/gcc.svg',
            //                                 color: Colors.black,
            //                                 height: 20.h,
            //                                 width: 20.w),
            //                             SizedBox(width: 5.w),
            //                             SizedBox(
            //                               width: 140.w,
            //                               child: listenData.car.specsType == 1
            //                                   ? const AutoSizeText(
            //                                       'GCC specs: YES',
            //                                       maxLines: 1,
            //                                       maxFontSize: 11,
            //                                       minFontSize: 10,
            //                                     )
            //                                   : const AutoSizeText(
            //                                       'GCC specs: NO',
            //                                       maxLines: 1,
            //                                       maxFontSize: 14,
            //                                     ),
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 'assets/images/svg/bags.svg',
            //                                 color: Colors.black,
            //                                 height: 20.h,
            //                                 width: 20.w),
            //                             SizedBox(width: 5.w),
            //                             Text('${listenData.car.bags} Bag(s)'),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 'assets/images/svg/engine.svg',
            //                                 color: Colors.black,
            //                                 height: 20.h,
            //                                 width: 20.w),
            //                             SizedBox(width: 5.w),
            //                             Text(
            //                                 'Engine capacity: ${listenData.car.engineCapacity}L'),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(height: 15.h),
            //                     const Divider(indent: 0, endIndent: 0),
            //                     SizedBox(height: 15.h),
            //                     Text(
            //                       'Additions',
            //                       style: Theme.of(context).textTheme.headline1,
            //                     ),
            //                     Padding(
            //                       padding:
            //                           EdgeInsets.symmetric(horizontal: 18.w),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: const [
            //                               Text('Additional driver insurance'),
            //                               Spacer(),
            //                               Text('AED 100'),
            //                             ],
            //                           ),
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: [
            //                               const Text(
            //                                   'Additional mileage charge'),
            //                               const Spacer(),
            //                               Text(
            //                                   'AED ${listenData.car.extraMileageCost} /km'),
            //                             ],
            //                           ),
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: const [
            //                               Text('Salik / Toll charges'),
            //                               Spacer(),
            //                               Text('AED 5'),
            //                             ],
            //                           ),
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: [
            //                               const Text('Excess claim'),
            //                               const Spacer(),
            //                               Text(
            //                                   'AED ${listenData.car.excessClaim}'),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     const Gap(height: 15),
            //                     const Divider(indent: 0, endIndent: 0),
            //                     SizedBox(height: 15.h),
            //                     Text(
            //                       'Requirements',
            //                       style: Theme.of(context).textTheme.headline1,
            //                     ),
            //                     Padding(
            //                       padding:
            //                           EdgeInsets.symmetric(horizontal: 18.w),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: [
            //                               const Text('Driver\'s age'),
            //                               const Spacer(),
            //                               Text(
            //                                   '${listenData.car.driverAge} years and older'),
            //                             ],
            //                           ),
            //                           SizedBox(height: 15.h),
            //                           Row(
            //                             children: [
            //                               const Text('Security deposit'),
            //                               const Spacer(),
            //                               Text(
            //                                   'AED ${listenData.car.options[1]}'),
            //                             ],
            //                           ),
            //                           SizedBox(height: 15.h),
            //                           Container(
            //                             padding: EdgeInsets.symmetric(
            //                                 horizontal: 7.w, vertical: 4.h),
            //                             decoration: BoxDecoration(
            //                                 borderRadius:
            //                                     BorderRadius.circular(15.r),
            //                                 border: Border.all(
            //                                     color: Theme.of(context)
            //                                         .primaryColor)),
            //                             child: Text(
            //                               'Documents required',
            //                               style: Theme.of(context)
            //                                   .textTheme
            //                                   .headline2,
            //                             ),
            //                           ),
            //                           const Gap(height: 15)
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 15.h),
            //               const DeliveryContainerWidget(),
            //               SizedBox(height: 15.h),
            //               // SpecContainerWidget(
            //               //   isWidth: true,
            //               //   widget: Column(
            //               //     crossAxisAlignment: CrossAxisAlignment.start,
            //               //     children: [
            //               //       Text(
            //               //         'Car specs',
            //               //         style: Theme.of(context).textTheme.headline1,
            //               //       ),
            //               //       GridView(
            //               //         shrinkWrap: true,
            //               //         physics: const NeverScrollableScrollPhysics(),
            //               //         gridDelegate:
            //               //             const SliverGridDelegateWithFixedCrossAxisCount(
            //               //                 crossAxisCount: 2,
            //               //                 childAspectRatio: 5),
            //               //         children: [
            //               //           Row(
            //               //             mainAxisSize: MainAxisSize.min,
            //               //             children: [
            //               //               Icon(
            //               //                 Icons.directions_car,
            //               //                 // color: Colors.red,
            //               //                 size: 24.r,
            //               //               ),
            //               //               SizedBox(width: 5.w),
            //               //               SizedBox(
            //               //                   width: 140.w,
            //               //                   child: listenData
            //               //                               .car.transmissionType ==
            //               //                           1
            //               //                       ? const AutoSizeText(
            //               //                           'Transmission: AUTO',
            //               //                           maxLines: 1,
            //               //                           maxFontSize: 11,
            //               //                           minFontSize: 10,
            //               //                         )
            //               //                       : const AutoSizeText(
            //               //                           'Transmission: MANUAL',
            //               //                           maxLines: 1,
            //               //                           maxFontSize: 11,
            //               //                           minFontSize: 10,
            //               //                         )),
            //               //             ],
            //               //           ),
            //               //           Row(
            //               //             mainAxisSize: MainAxisSize.min,
            //               //             children: [
            //               //               const Icon(
            //               //                 Icons.car_rental,
            //               //                 color: Colors.red,
            //               //               ),
            //               //               SizedBox(width: 5.w),
            //               //               SizedBox(
            //               //                 child: SizedBox(
            //               //                     width: 140.w,
            //               //                     child: AutoSizeText(
            //               //                       listenData.car.type,
            //               //                       maxFontSize: 11,
            //               //                       minFontSize: 10,
            //               //                     )),
            //               //               ),
            //               //             ],
            //               //           ),
            //               //           Row(
            //               //             mainAxisSize: MainAxisSize.min,
            //               //             children: [
            //               //               Image.asset(
            //               //                   'assets/images/vector13Red.png',
            //               //                   height: 20.h,
            //               //                   width: 20.w),
            //               //               SizedBox(width: 5.w),
            //               //               SizedBox(
            //               //                   width: 140.w,
            //               //                   child: AutoSizeText(
            //               //                     '${listenData.car.doors} doors',
            //               //                     maxFontSize: 11,
            //               //                     minFontSize: 10,
            //               //                   )),
            //               //             ],
            //               //           ),
            //               //           Row(
            //               //             mainAxisSize: MainAxisSize.min,
            //               //             children: [
            //               //               Icon(
            //               //                 Icons.backpack,
            //               //                 size: 20.r,
            //               //                 color: Theme.of(context).primaryColor,
            //               //               ),
            //               //               SizedBox(width: 5.w),
            //               //               Text('${listenData.car.seat} seats'),
            //               //             ],
            //               //           ),
            //               //           Row(
            //               //             mainAxisSize: MainAxisSize.min,
            //               //             children: [
            //               //               Image.asset(
            //               //                   'assets/images/vector13Red.png',
            //               //                   height: 20,
            //               //                   width: 20),
            //               //               SizedBox(width: 5.w),
            //               //               SizedBox(
            //               //                 width: 140.w,
            //               //                 child: listenData.car.specsType == 1
            //               //                     ? const AutoSizeText(
            //               //                         'GCC specs: YES',
            //               //                         maxLines: 1,
            //               //                         maxFontSize: 11,
            //               //                         minFontSize: 10,
            //               //                       )
            //               //                     : const AutoSizeText(
            //               //                         'GCC specs: NO',
            //               //                         maxLines: 1,
            //               //                         maxFontSize: 14,
            //               //                       ),
            //               //               ),
            //               //             ],
            //               //           ),
            //               //           Row(
            //               //             mainAxisSize: MainAxisSize.min,
            //               //             children: [
            //               //               const Icon(
            //               //                 Icons.backpack,
            //               //                 color: Colors.red,
            //               //               ),
            //               //               SizedBox(width: 5.w),
            //               //               Text('${listenData.car.bags} Bag(s)'),
            //               //             ],
            //               //           ),
            //               //           Row(
            //               //             mainAxisSize: MainAxisSize.min,
            //               //             children: [
            //               //               const Icon(Icons.engineering),
            //               //               SizedBox(width: 5.w),
            //               //               Text(
            //               //                   'Engine capacity: ${listenData.car.engineCapacity}L'),
            //               //             ],
            //               //           )
            //               //         ],
            //               //       ),
            //               //       SizedBox(height: 15.h),
            //               //       Divider(indent: 15.w, endIndent: 15.w),
            //               //       SizedBox(height: 15.h),
            //               //       Text(
            //               //         'Car features',
            //               //         style: Theme.of(context).textTheme.headline1,
            //               //       ),

            //               //       // ...widget.car.features.map((e) => ,),

            //               //       GridView.builder(
            //               //         shrinkWrap: true,
            //               //         itemCount: listenData.car.features.length,
            //               //         gridDelegate:
            //               //             const SliverGridDelegateWithFixedCrossAxisCount(
            //               //                 crossAxisCount: 2,
            //               //                 childAspectRatio: 5),
            //               //         physics: const NeverScrollableScrollPhysics(),
            //               //         itemBuilder: (context, index) => Row(
            //               //           mainAxisSize: MainAxisSize.min,
            //               //           children: [
            //               //             SvgPicture.network(
            //               //                 listenData.car.features[index].image,
            //               //                 height: 20.h,
            //               //                 width: 20.w),
            //               //             SizedBox(width: 5.w),
            //               //             SizedBox(
            //               //               width: 140.w,
            //               //               child: AutoSizeText(
            //               //                 listenData.car.features[index].name,
            //               //                 maxFontSize: 11,
            //               //                 minFontSize: 10,
            //               //                 overflow: TextOverflow.ellipsis,
            //               //                 maxLines: 1,
            //               //               ),
            //               //             ),
            //               //           ],
            //               //         ),
            //               //       )
            //               //     ],
            //               //   ),
            //               // ),
            //               // SizedBox(height: 15.h),

            //               Row(
            //                 children: [
            //                   Text(
            //                     'Description',
            //                     style: Theme.of(context).textTheme.headline1,
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(height: 10.h),
            //               Container(
            //                 width: 320.w,
            //                 padding: EdgeInsets.symmetric(horizontal: 5.w),
            //                 child: Text(
            //                   listenData.car.description,
            //                 ),
            //               ),

            //               SizedBox(height: 15.h),
            //               // Image.asset('assets/images/30.png'),
            //             ],
            //           ),
            //         ),
            //         SizedBox(height: 38.h),
            //         BestOffersWidget(
            //           title: 'Our best offers',
            //           option: 1,
            //           car: context.read<AcceuilProvider>().latestBestOffers,
            //         )
            //       ],
            //     ),
            //   ),
      











  //      Future<void> _phone(int carID) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: '+1-555-010-999',
  //   );
  //   await context
  //       .read<StatisticsProvider>()
  //       .staticsFct(1, carID)
  //       .then((_) async {
  //     await launchUrl(launchUri);
  //   });
  // }

  // void _openWhatsApp() async {
  //   await canLaunch(
  //           'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
  //       ? await launch(
  //           'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
  //       : throw 'Could not launch WhatsApp';
  // }

  // void _openWhatsApp(int carID) async {
  //   await context
  //       .read<StatisticsProvider>()
  //       .staticsFct(2, carID)
  //       .then((_) async {
  //     await canLaunch(
  //             'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
  //         ? await launch(
  //             'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
  //         : throw 'Could not launch WhatsApp';
  //   });
  // }

  // Future _openMail(int carID, String agencyName, String carName) async {
  //   const mailTo = 'azzi.youssef@excelenciatech.com';
  //   const subject = 'I want to rent a car';
  //   var message =
  //       'Hello, \n\nI am writing this letter to your agency $agencyName for the purpose of renting the $carName displayed on the app Drivers City and I would like to know whether the said car is available with you or not. As I am in a hurry I would be very grateful if you could mail me the conditions’ rent.\n\nI hope that you would revert back to me as soon as possible with the necessary details.\n\nThanking you,\n\nSincerely';
  //   final url =
  //       'mailto:$mailTo?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';

  //   await context
  //       .read<StatisticsProvider>()
  //       .staticsFct(3, carID)
  //       .then((_) async {
  //     // if (await canLaunch(url)) {
  //     launch(url);
  //     // }
  //   });
  // }

  // void _navigateToAgency(int agencyID) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AgencyScreen(agencyId: agencyID),
  //       ));
  // }
