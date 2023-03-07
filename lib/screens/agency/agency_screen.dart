import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_access/helpers/agency_info_dialog.dart';
import 'package:dream_access/providers/agency_provider.dart';
import 'package:dream_access/screens/agency/agency_info.dart';
import 'package:dream_access/widgets/agency/car_widget.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:dream_access/widgets/home/cardetail/car_detail_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';

class AgencyScreen extends StatefulWidget {
  const AgencyScreen({super.key, required this.agencyId});
  final int agencyId;
  @override
  State<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      context.watch<AgencyProvider>().agencyFct(widget.agencyId).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<AgencyProvider>();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading:
      // ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.red, size: 50.r))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: GeneralData.width),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // agencyInfoDialog(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AgencyInfo(
                                        agency: listenData.agency[0]),
                                  ));
                            },
                            child: Container(
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Text(
                                  'Agence info',
                                  style: Theme.of(context).textTheme.headline1,
                                )),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: GeneralData.width),
                    //   child:
                    // ),
                    const Gap(height: 15),
                    ...listenData.agency[0].cars.map(
                      (e) => CarWidget(car: e),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
