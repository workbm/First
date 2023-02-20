import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../constants/list_cars.dart';
import '../../providers/acceuil_provider.dart';
import '../../widgets/home/best_offers_widget.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

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
                          'Terms and conditions:',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      'These Website Standard Terms and Conditions written on this webpage shall manage your use of our website, Website Name accessible at Website URL.\n\nBy using our Website, you accepted these terms and conditions in full. If you disagree with these terms and conditions or any part of these terms and conditions, you must not use our Website.\n\nIntellectual Property Rights: Unless otherwise stated, we or our licensors own the intellectual property rights in the website and material on the website. Subject to the license below, all these intellectual property rights are reserved.\n\nLicense to use website: You may view, download for caching purposes only, and print pages from the website for your own personal use, subject to the restrictions set out in these terms and conditions.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'You must not:',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 15.h),
                    // Text(
                    //   'We collect various types of information from and about users of our Site, including information:',
                    //   textAlign: TextAlign.justify,
                    // ),
                    // SizedBox(height: 15.h),
                    Text(
                      '** Republish material from this website (including republication on another website).',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** Sell, rent or sub-license material from the website',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      '** Show any material from the website in public.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** Reproduce, duplicate, copy or otherwise exploit material on our website for a commercial purpose.',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      '** Edit or otherwise modify any material on the website ...',
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
                option: 1,
                car: data.latestBestOffers,
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
