import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/constants/general_data.dart';
import 'package:dream_access/providers/acceuil_provider.dart';
import 'package:dream_access/widgets/car_detail/delivery_container_widget.dart';
import 'package:dream_access/widgets/car_detail/spec_container_widget.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/home/best_offers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/car.dart';
import '../../providers/statistics_provider.dart';
import '../agency/agency_screen.dart';

class CarDetail extends StatefulWidget {
  const CarDetail({super.key, required this.car});
  final Car car;

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // @override
  // void initState() {
  //   _tabController = TabController(length: 3, vsync: this);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    void openWhatsApp(int carID) async {
      await context
          .read<StatisticsProvider>()
          .staticsFct(2, carID)
          .then((_) async {
        await canLaunch(
                'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
            ? await launch(
                'https://api.whatsapp.com/send?phone=212656949348&text=Hello%2c')
            : throw 'Could not launch WhatsApp';
      });
    }

    Future<void> phone(int carID) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: '+1-555-010-999',
      );
      await context
          .read<StatisticsProvider>()
          .staticsFct(1, carID)
          .then((_) async {
        await launchUrl(launchUri);
      });
    }

    Future openMailApp(int carID, String agencyName, String carName) async {
      const mailTo = 'azzi.youssef@excelenciatech.com';
      const subject = 'Inquiry to rent';
      var message =
          'Hello, \n\nI am writing this letter to your agency $agencyName for the purpose of renting the $carName displayed on the app Drivers City and I would like to know whether the said car is available with you or not. As I am in a hurry I would be very grateful if you could mail me the conditions’ rent.\n\nI hope that you would revert back to me as soon as possible with the necessary details.\n\nThanking you,\n\nSincerely';
      final url =
          'mailto:$mailTo?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
      await context
          .read<StatisticsProvider>()
          .staticsFct(3, carID)
          .then((_) async {
        // if (await canLaunch(url)) {
        launch(url);
        // }
      });
    }

    void _navigateToAgency(int agencyID) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgencyScreen(agencyId: agencyID),
          ));
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GeneralData.width2,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 250.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 250.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.car.image[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 39.r,
                        //   left: 39.r,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       InkWell(
                        //         onTap: () {
                        //           phone(widget.car.id);
                        //         },
                        //         child: CircleAvatar(
                        //           radius: 36.r,
                        //           backgroundColor:
                        //               Theme.of(context).primaryColor,
                        //           child:
                        //               Image.asset('assets/images/appel1.png'),
                        //         ),
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           openWhatsApp(widget.car.id);
                        //         },
                        //         child: CircleAvatar(
                        //           radius: 36.r,
                        //           backgroundColor: const Color(0xff8BC442),
                        //           child:
                        //               Image.asset('assets/images/watssap.png'),
                        //         ),
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           openMailApp(widget.car.id,
                        //               widget.car.agencyName, widget.car.name);
                        //         },
                        //         child: CircleAvatar(
                        //           radius: 36.r,
                        //           backgroundColor: Colors.black,
                        //           child: Image.asset('assets/images/mail1.png'),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        IconButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        )
                      ],
                    ),
                    const Gap(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            phone(widget.car.id);
                          },
                          child: CircleAvatar(
                            radius: 36.r,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Image.asset('assets/images/appel1.png'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            openWhatsApp(widget.car.id);
                          },
                          child: CircleAvatar(
                            radius: 36.r,
                            backgroundColor: GeneralData.whatsAppColor,
                            child: Image.asset('assets/images/watssap.png'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            openMailApp(widget.car.id, widget.car.agencyName,
                                widget.car.name);
                          },
                          child: CircleAvatar(
                            radius: 36.r,
                            backgroundColor: Colors.black,
                            child: Image.asset('assets/images/mail1.png'),
                          ),
                        ),
                      ],
                    ),
                    const Gap(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: GeneralData.borderColor),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                              height: 121.h,
                              width: 114.w,
                              padding: EdgeInsets.all(3.r),
                              child: GestureDetector(
                                onTap: () {
                                  _navigateToAgency(widget.car.agence[0].id);
                                },
                                child: CachedNetworkImage(
                                  imageUrl: widget.car.agencyLogo,
                                ),
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160.w,
                                // height: 50.h,
                                child: AutoSizeText(
                                  widget.car.name,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Icon(Icons.done, size: 20.r),
                                  Text(widget.car.options[0]),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.done, size: 20.r),
                                  const Text('5%  VAT applicable'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       widget.car.priceByDay.toString(),
                    //       style: TextStyle(
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 15.h),

                    SizedBox(height: 15.h),
                    // VectorsWidget(car: widget.car),
                    // SizedBox(height: 15.h),
                    // ...widget.car.options.map(
                    //   (e) => Row(
                    //     children: [
                    //       CircleAvatar(
                    //         radius: 3.r,
                    //         backgroundColor: Colors.black,
                    //       ),
                    //       SizedBox(width: 10.w),
                    //       Text(e),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(height: 15.h),
                    // TabBar(
                    //     controller: _tabController,
                    //     unselectedLabelColor:
                    //         Color.fromARGB(255, 133, 133, 133),
                    //     labelColor: Theme.of(context).primaryColor,
                    //     tabs: [
                    //       Tab(
                    //         child: FittedBox(
                    //             child: Text(
                    //           'AED ${widget.car.priceByDay} /day',
                    //           style: TextStyle(fontSize: 12),
                    //         )),
                    //       ),
                    //       Tab(
                    //         child: FittedBox(
                    //             child: Text(
                    //                 'AED ${widget.car.priceByMonth} /week',
                    //                 style: TextStyle(fontSize: 13))),
                    //       ),
                    //       Tab(
                    //         child: FittedBox(
                    //             child: Text(
                    //                 'AED ${widget.car.priceByMonth} /month',
                    //                 style: TextStyle(fontSize: 14))),
                    //       ),
                    //     ]),
                    // SizedBox(
                    //   height: 500,
                    //   child: TabBarView(controller: _tabController, children: [
                    //     Container(child: Center(child: Text('people'))),
                    //     Text('Person'),
                    //     Text('data'),
                    //   ]),
                    // ),

                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: GeneralData.borderColorModel),
                          borderRadius: BorderRadius.circular(25.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'AED ${widget.car.priceByDay.toString()}/day',
                            // style: const TextStyle(color: Colors.white),
                          ),
                          VerticalDivider(
                            color: Colors.red,
                            indent: 10.h,
                            endIndent: 10.h,
                          ),
                          Text(
                            'AED ${widget.car.priceByWeek.toString()}/week',
                            // style: const TextStyle(color: Colors.white),
                          ),
                          VerticalDivider(
                            color: Colors.red,
                            indent: 10.h,
                            endIndent: 10.h,
                          ),
                          Text(
                            'AED ${widget.car.priceByMonth.toString()}/month',
                            // style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    SpecContainerWidget(
                      isWidth: false,
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rental includes',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                Row(
                                  children: const [
                                    Text('Insurance'),
                                    Spacer(),
                                    Text('Basic comprehensive'),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                const Text('Extras'),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                          const Divider(indent: 0, endIndent: 0),
                          SizedBox(height: 15.h),
                          Text(
                            'Car color',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    const Text('Exterior'),
                                    const Spacer(),
                                    ...widget.car.exterColor
                                        .map(
                                          (e) => Container(
                                            margin: EdgeInsets.only(left: 3.w),
                                            height: 13.h,
                                            width: 13.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 0.5),
                                                color: Color(
                                                    (int.parse(e.value)))),
                                          ),
                                        )
                                        .toList(),
                                    // Container(
                                    //   height: 13.h,
                                    //   width: 13.w,
                                    //   decoration: const BoxDecoration(
                                    //       color: Colors.red),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    const Text('Interior'),
                                    const Spacer(),
                                    ...widget.car.interColor
                                        .map(
                                          (e) => Container(
                                            margin: EdgeInsets.only(left: 3.w),
                                            height: 13.h,
                                            width: 13.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 0.5),
                                                color: Color(
                                                    (int.parse(e.value)))),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                          const Divider(indent: 0, endIndent: 0),
                          const Gap(height: 15),
                          Text(
                            'Car specs',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const Gap(height: 15),
                          GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 5),
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/svg/transmission.svg',
                                      height: 20.h,
                                      width: 20.w),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                      width: 140.w,
                                      child: widget.car.transmissionType == 1
                                          ? const AutoSizeText(
                                              'Transmission: AUTO',
                                              maxLines: 1,
                                              maxFontSize: 11,
                                              minFontSize: 10,
                                            )
                                          : const AutoSizeText(
                                              'Transmission: MANUAL',
                                              maxLines: 1,
                                              maxFontSize: 11,
                                              minFontSize: 10,
                                            )),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset('assets/images/svg/car.svg',
                                      color: Colors.black,
                                      height: 20.h,
                                      width: 20.w),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    child: SizedBox(
                                        width: 120.w,
                                        child: AutoSizeText(
                                          widget.car.type,
                                          maxFontSize: 11,
                                          minFontSize: 10,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/svg/doors.svg',
                                      color: Colors.black,
                                      height: 20.h,
                                      width: 20.w),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                      width: 140.w,
                                      child: AutoSizeText(
                                        '${widget.car.doors} doors',
                                        maxFontSize: 11,
                                        minFontSize: 10,
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/svg/seats.svg',
                                      color: Colors.black,
                                      height: 20.h,
                                      width: 20.w),
                                  SizedBox(width: 5.w),
                                  Text('${widget.car.seat} seats'),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset('assets/images/svg/gcc.svg',
                                      color: Colors.black,
                                      height: 20.h,
                                      width: 20.w),
                                  SizedBox(width: 5.w),
                                  SizedBox(
                                    width: 140.w,
                                    child: widget.car.specsType == 1
                                        ? const AutoSizeText(
                                            'GCC specs: YES',
                                            maxLines: 1,
                                            maxFontSize: 11,
                                            minFontSize: 10,
                                          )
                                        : const AutoSizeText(
                                            'GCC specs: NO',
                                            maxLines: 1,
                                            maxFontSize: 14,
                                          ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset('assets/images/svg/bags.svg',
                                      color: Colors.black,
                                      height: 20.h,
                                      width: 20.w),
                                  SizedBox(width: 5.w),
                                  Text('${widget.car.bags} Bag(s)'),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/svg/engine.svg',
                                      color: Colors.black,
                                      height: 20.h,
                                      width: 20.w),
                                  SizedBox(width: 5.w),
                                  Text(
                                      'Engine capacity: ${widget.car.engineCapacity}L'),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15.h),
                          const Divider(indent: 0, endIndent: 0),
                          const Gap(height: 15),
                          Text(
                            'Additions',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                Row(
                                  children: const [
                                    Text('Additional driver insurance'),
                                    Spacer(),
                                    Text('AED 100'),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    const Text('Additional mileage charge'),
                                    const Spacer(),
                                    Text(
                                        'AED ${widget.car.extraMileageCost} /km'),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: const [
                                    Text('Salik / Toll charges'),
                                    Spacer(),
                                    Text('AED 5'),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    const Text('Excess claim'),
                                    const Spacer(),
                                    Text('AED ${widget.car.excessClaim}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(indent: 0, endIndent: 0),
                          SizedBox(height: 15.h),
                          Text(
                            'Requirements',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    const Text('Driver\'s age'),
                                    const Spacer(),
                                    Text(
                                        '${widget.car.driverAge} years and older'),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    const Text('Security deposit'),
                                    const Spacer(),
                                    Text('AED ${widget.car.options[1]}'),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  child: Text(
                                    'Documents required',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    const DeliveryContainerWidget(),
                    SizedBox(height: 15.h),
                    // SpecContainerWidget(
                    //   isWidth: true,
                    //   widget: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Car specs',
                    //         style: Theme.of(context).textTheme.headline1,
                    //       ),
                    //       GridView(
                    //         shrinkWrap: true,
                    //         physics: const NeverScrollableScrollPhysics(),
                    //         gridDelegate:
                    //             const SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 2, childAspectRatio: 5),
                    //         children: [
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Icon(
                    //                 Icons.directions_car,
                    //                 size: 24.r,
                    //               ),
                    //               SizedBox(width: 5.w),
                    //               SizedBox(
                    //                   width: 140.w,
                    //                   child: widget.car.transmissionType == 1
                    //                       ? const AutoSizeText(
                    //                           'Transmission: AUTO',
                    //                           maxLines: 1,
                    //                           maxFontSize: 11,
                    //                           minFontSize: 10,
                    //                         )
                    //                       : const AutoSizeText(
                    //                           'Transmission: MANUAL',
                    //                           maxLines: 1,
                    //                           maxFontSize: 11,
                    //                           minFontSize: 10,
                    //                         )),
                    //             ],
                    //           ),
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               const Icon(
                    //                 Icons.car_rental,
                    //                 color: Colors.red,
                    //               ),
                    //               SizedBox(width: 5.w),
                    //               SizedBox(
                    //                 child: SizedBox(
                    //                     width: 140.w,
                    //                     child: AutoSizeText(
                    //                       widget.car.type,
                    //                       maxFontSize: 11,
                    //                       minFontSize: 10,
                    //                     )),
                    //               ),
                    //             ],
                    //           ),
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Image.asset('assets/images/vector13Red.png',
                    //                   height: 20.h, width: 20.w),
                    //               SizedBox(width: 5.w),
                    //               SizedBox(
                    //                   width: 140.w,
                    //                   child: AutoSizeText(
                    //                     '${widget.car.doors} doors',
                    //                     maxFontSize: 11,
                    //                     minFontSize: 10,
                    //                   )),
                    //             ],
                    //           ),
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Icon(
                    //                 Icons.backpack,
                    //                 size: 20.r,
                    //                 color: Theme.of(context).primaryColor,
                    //               ),
                    //               SizedBox(width: 5.w),
                    //               Text('${widget.car.seat} seats'),
                    //             ],
                    //           ),
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               Image.asset('assets/images/vector13Red.png',
                    //                   height: 20, width: 20),
                    //               SizedBox(width: 5.w),
                    //               SizedBox(
                    //                 width: 140.w,
                    //                 child: widget.car.specsType == 1
                    //                     ? const AutoSizeText(
                    //                         'GCC specs: YES',
                    //                         maxLines: 1,
                    //                         maxFontSize: 11,
                    //                         minFontSize: 10,
                    //                       )
                    //                     : const AutoSizeText(
                    //                         'GCC specs: NO',
                    //                         maxLines: 1,
                    //                         maxFontSize: 14,
                    //                       ),
                    //               ),
                    //             ],
                    //           ),
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               const Icon(
                    //                 Icons.backpack,
                    //                 color: Colors.red,
                    //               ),
                    //               SizedBox(width: 5.w),
                    //               Text('${widget.car.bags} Bag(s)'),
                    //             ],
                    //           ),
                    //           Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               const Icon(Icons.engineering),
                    //               SizedBox(width: 5.w),
                    //               Text(
                    //                   'Engine capacity: ${widget.car.engineCapacity}L'),
                    //             ],
                    //           )
                    //         ],
                    //       ),

                    //       // Column(
                    //       //   crossAxisAlignment: CrossAxisAlignment.start,
                    //       //   children: [
                    //       //     SizedBox(height: 15.h),
                    //       //     Row(
                    //       //       children: [
                    //       //         const Icon(
                    //       //           Icons.directions_car,
                    //       //           color: Colors.red,
                    //       //         ),
                    //       //         SizedBox(width: 5.w),
                    //       //         SizedBox(
                    //       //             width: 140.w,
                    //       //             child: widget.car.transmissionType == 1
                    //       //                 ? const AutoSizeText(
                    //       //                     'Transmission: AUTO',
                    //       //                     maxLines: 1,
                    //       //                     maxFontSize: 11,
                    //       //                     minFontSize: 10,
                    //       //                   )
                    //       //                 : const AutoSizeText(
                    //       //                     'Transmission: MANUAL',
                    //       //                     maxLines: 1,
                    //       //                     maxFontSize: 11,
                    //       //                     minFontSize: 10,
                    //       //                   )),
                    //       //         SizedBox(width: 30.w),
                    //       //         const Icon(
                    //       //           Icons.car_rental,
                    //       //           color: Colors.red,
                    //       //         ),
                    //       //         SizedBox(width: 5.w),
                    //       //         SizedBox(
                    //       //           child: SizedBox(
                    //       //               width: 85.w,
                    //       //               child: AutoSizeText(
                    //       //                 widget.car.type,
                    //       //                 maxFontSize: 11,
                    //       //                 minFontSize: 10,
                    //       //               )),
                    //       //         ),
                    //       //       ],
                    //       //     ),
                    //       //     SizedBox(height: 15.h),
                    //       //     Row(
                    //       //       children: [
                    //       //         Image.asset('assets/images/vector13Red.png',
                    //       //             height: 24, width: 24),
                    //       //         SizedBox(width: 5.w),
                    //       //         SizedBox(
                    //       //             width: 140.w,
                    //       //             child: AutoSizeText(
                    //       //               '${widget.car.doors} doors',
                    //       //               maxFontSize: 11,
                    //       //               minFontSize: 10,
                    //       //             )),
                    //       //         SizedBox(width: 30.w),
                    //       //         Icon(
                    //       //           Icons.backpack,
                    //       //           color: Theme.of(context).primaryColor,
                    //       //         ),
                    //       //         SizedBox(width: 5.w),
                    //       //         Text('${widget.car.seat} seats'),
                    //       //       ],
                    //       //     ),
                    //       //     SizedBox(height: 15.h),
                    //       //     Row(
                    //       //       children: [
                    //       //         Image.asset('assets/images/vector13Red.png',
                    //       //             height: 24, width: 24),
                    //       //         SizedBox(width: 5.w),
                    //       //         SizedBox(
                    //       //           width: 140.w,
                    //       //           child: widget.car.specsType == 1
                    //       //               ? const AutoSizeText(
                    //       //                   'GCC specs: YES',
                    //       //                   maxLines: 1,
                    //       //                   maxFontSize: 11,
                    //       //                   minFontSize: 10,
                    //       //                 )
                    //       //               : const AutoSizeText(
                    //       //                   'GCC specs: NO',
                    //       //                   maxLines: 1,
                    //       //                   maxFontSize: 14,
                    //       //                 ),
                    //       //         ),
                    //       //         SizedBox(width: 30.w),
                    //       //         const Icon(
                    //       //           Icons.backpack,
                    //       //           color: Colors.red,
                    //       //         ),
                    //       //         SizedBox(width: 5.w),
                    //       //         Text('${widget.car.bags} Bag(s)'),
                    //       //       ],
                    //       //     ),
                    //       //     SizedBox(height: 15.h),
                    //       //     Row(
                    //       //       children: [
                    //       //         const Icon(Icons.engineering),
                    //       //         SizedBox(width: 5.w),
                    //       //         Text(
                    //       //             'Engine capacity: ${widget.car.engineCapacity}L')
                    //       //       ],
                    //       //     )
                    //       //   ],
                    //       // ),

                    //       SizedBox(height: 15.h),
                    //       Divider(indent: 15.w, endIndent: 15.w),
                    //       SizedBox(height: 15.h),
                    //       Text(
                    //         'Car features',
                    //         style: Theme.of(context).textTheme.headline1,
                    //       ),

                    //       // ...widget.car.features.map((e) => ,),

                    //       GridView.builder(
                    //         shrinkWrap: true,
                    //         itemCount: widget.car.features.length,
                    //         gridDelegate:
                    //             const SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 2, childAspectRatio: 5),
                    //         physics: const NeverScrollableScrollPhysics(),
                    //         itemBuilder: (context, index) => Row(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             SvgPicture.network(
                    //                 widget.car.features[index].image,
                    //                 height: 20.h,
                    //                 width: 20.w),
                    //             SizedBox(width: 5.w),
                    //             SizedBox(
                    //               width: 140.w,
                    //               child: AutoSizeText(
                    //                 widget.car.features[index].name,
                    //                 maxFontSize: 11,
                    //                 minFontSize: 10,
                    //                 overflow: TextOverflow.ellipsis,
                    //                 maxLines: 1,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )

                    //       // Padding(
                    //       //   padding: EdgeInsets.only(left: 18.w),
                    //       //   child: Column(
                    //       //     crossAxisAlignment: CrossAxisAlignment.start,
                    //       //     children: [
                    //       //       SizedBox(height: 15.h),
                    //       //       Row(
                    //       //         children: [
                    //       //           SizedBox(
                    //       //             child: widget.car.features.isNotEmpty
                    //       //                 ? SvgPicture.network(
                    //       //                     widget.car.features[0].image,
                    //       //                     height: 20.h,
                    //       //                     width: 20.w)
                    //       //                 : Image.asset(
                    //       //                     'assets/images/vector14.png',
                    //       //                     height: 20.h,
                    //       //                     width: 20.w),
                    //       //           ),
                    //       //           SizedBox(width: 5.w),
                    //       //           SizedBox(
                    //       //               width: 140.w,
                    //       //               child: widget.car.transmissionType == 1
                    //       //                   ? const AutoSizeText(
                    //       //                       'Transmission: AUTO',
                    //       //                       maxLines: 1,
                    //       //                       maxFontSize: 14,
                    //       //                     )
                    //       //                   : const AutoSizeText(
                    //       //                       'Transmission: MANUAL',
                    //       //                       maxLines: 1,
                    //       //                       maxFontSize: 14,
                    //       //                     )),
                    //       //           SizedBox(width: 30.w),
                    //       //           const Icon(
                    //       //             Icons.car_rental,
                    //       //             color: Colors.red,
                    //       //           ),
                    //       //           SizedBox(width: 5.w),
                    //       //           SizedBox(
                    //       //             child: SizedBox(
                    //       //                 width: 85.w,
                    //       //                 child: AutoSizeText(
                    //       //                   widget.car.type,
                    //       //                   maxLines: 1,
                    //       //                 )),
                    //       //           ),
                    //       //         ],
                    //       //       ),
                    //       //       SizedBox(height: 15.h),
                    //       //       Row(
                    //       //         children: [
                    //       //           Image.asset('assets/images/vector13Red.png',
                    //       //               height: 24, width: 24),
                    //       //           SizedBox(width: 5.w),
                    //       //           SizedBox(
                    //       //               width: 140.w,
                    //       //               child: AutoSizeText(
                    //       //                 '${widget.car.doors} doors',
                    //       //                 maxFontSize: 14,
                    //       //                 maxLines: 1,
                    //       //               )),
                    //       //           SizedBox(width: 30.w),
                    //       //           Icon(
                    //       //             Icons.backpack,
                    //       //             color: Theme.of(context).primaryColor,
                    //       //           ),
                    //       //           SizedBox(width: 5.w),
                    //       //           Text('${widget.car.seat} seats'),
                    //       //         ],
                    //       //       ),
                    //       //       SizedBox(height: 15.h),
                    //       //       Row(
                    //       //         children: [
                    //       //           Image.asset('assets/images/vector13Red.png',
                    //       //               height: 24, width: 24),
                    //       //           SizedBox(width: 5.w),
                    //       //           SizedBox(
                    //       //             width: 140.w,
                    //       //             child: widget.car.specsType == 1
                    //       //                 ? const AutoSizeText(
                    //       //                     'GCC specs: YES',
                    //       //                     maxLines: 1,
                    //       //                     maxFontSize: 14,
                    //       //                   )
                    //       //                 : const AutoSizeText(
                    //       //                     'GCC specs: NO',
                    //       //                     maxLines: 1,
                    //       //                     maxFontSize: 14,
                    //       //                   ),
                    //       //           ),
                    //       //           SizedBox(width: 30.w),
                    //       //           const Icon(
                    //       //             Icons.backpack,
                    //       //             color: Colors.red,
                    //       //           ),
                    //       //           SizedBox(width: 5.w),
                    //       //           Text('${widget.car.bags} Bag(s)'),
                    //       //         ],
                    //       //       ),
                    //       //       SizedBox(height: 15.h),
                    //       //       Row(
                    //       //         children: [
                    //       //           const Icon(Icons.engineering),
                    //       //           SizedBox(width: 5.w),
                    //       //           Text(
                    //       //               'Engine capacity: ${widget.car.engineCapacity}L')
                    //       //         ],
                    //       //       )
                    //       //     ],
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),

                    // SizedBox(height: 15.h),
                    // Image.asset('assets/images/7.png'),
                    // SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 320.w,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        widget.car.description,
                      ),
                    ),

                    SizedBox(height: 15.h),
                    // Image.asset('assets/images/30.png'),
                  ],
                ),
              ),
              SizedBox(height: 38.h),
              BestOffersWidget(
                title: 'Our best offers',
                option: 1,
                car: context.read<AcceuilProvider>().latestBestOffers,
              )
            ],
          ),
        ),
      ),
    );
  }
}
