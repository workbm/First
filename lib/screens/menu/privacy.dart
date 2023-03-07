import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../constants/list_cars.dart';
import '../../providers/acceuil_provider.dart';
import '../../widgets/home/best_offers_widget.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    var data = context.watch<AcceuilProvider>();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text(
                          'Privacy policy:',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    // SizedBox(height: 10.h),
                    // Text(
                    //   'Introduction:',
                    //   style: Theme.of(context).textTheme.headline1,
                    // ),
                    SizedBox(height: 15.h),
                    const Text(
                      'This website is operated by Drivers City. We recognize the importance of protecting the privacy of all information provided by users of our Site, and have established this Privacy Policy to communicate our information collection, use, and dissemination practices.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Information Collection and Use:',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'We collect various types of information from and about users of our Site, including information:',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** By which you may be personally identified, such as name, postal address, e-mail address, telephone number, or any other identifier by which you may be contacted online or offline ("personal information");',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** About your internet connection, the equipment you use to access our Site, and usage details.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text('We collect this information:'),
                    SizedBox(height: 15.h),
                    const Text(
                      '** Directly from you when you provide it to us.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** Automatically as you navigate through the site. Information collected automatically may include usage details, IP addresses, and information collected through cookies, web beacons, and other tracking technologies. We use information that we collect about you or that',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** To present our Site and its contents to you.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** To provide you with information, products, or services that you request from us.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** To fulfill any other purpose for which you provide it',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** To carry out our obligations and enforce our rights arising from any contracts entered into between you and us, including for billing and collection.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** To notify you about changes to our Site or any products or services we offer or provide though it.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {},
                            child: const Text('Read more'))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 38.h),
              BestOffersWidget(
                title: 'Our best offers',
                option: 1,
                car: data.latestBestOffers,
              )
            ],
          ),
        ),
      ),
    );
  }
}
