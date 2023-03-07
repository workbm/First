import 'package:dream_access/providers/filter_provider.dart';
import 'package:dream_access/providers/search_by_filter_provider.dart';
import 'package:dream_access/screens/filter/filtered_cars.dart';
import 'package:dream_access/widgets/filter/brands_with_models_widget.dart';
import 'package:dream_access/widgets/filter/budget_widget.dart';
import 'package:dream_access/widgets/filter/minimum_age_widget.dart';
import 'package:dream_access/widgets/filter/model_year_widget.dart';
import 'package:dream_access/widgets/filter/rental_period_widget.dart';
import 'package:dream_access/widgets/filter/title_widget.dart';
import 'package:dream_access/widgets/filter/vehicle_type_widget.dart';
import 'package:dream_access/widgets/helpers/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../widgets/filter/car_color_widget.dart';
import '../../widgets/filter/features_widget.dart';
import '../../widgets/filter/seats_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isInit = true;
  var _isLoading = false;
  final _key = GlobalKey<FormState>();
  final _dailyController = TextEditingController();
  final _monthlyController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      context.watch<FilterProvider>().filterFct().then((_) {
        context.read<FilterProvider>().filterPressedFct(false);
        context.read<SearchByFilterProvider>().clearFct();
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dailyController.dispose();
    _monthlyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<FilterProvider>();
    return Scaffold(
      bottomNavigationBar: !listenData.filterPressed
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     fixedSize: Size(150.w, 30.h),
                //     backgroundColor: Colors.white,
                //   ),
                //   onPressed: () {
                //     context.read<SearchByFilterProvider>().clearFct();
                //   },
                //   child: Text(
                //     'Clear',
                //     style: TextStyle(color: Theme.of(context).primaryColor),
                //   ),
                // ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        150.w,
                        30.h,
                      ),
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilteredCars(),
                        )).then((value) {
                      setState(() {
                        setState(() {
                          _isLoading = true;
                        });
                        context.read<FilterProvider>().filterFct().then((_) {
                          context
                              .read<FilterProvider>()
                              .filterPressedFct(false);
                          context.read<SearchByFilterProvider>().clearFct();
                          setState(() {
                            _isLoading = false;
                          });
                        });
                      });
                    });
                  },
                  child: const Text('Show cars'),
                ),
              ],
            ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.red, size: 50.r))
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: GeneralData.width),
                child: SingleChildScrollView(
                    child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(height: 15),
                      const TitleWidget(),
                      const Gap(height: 15),
                      Text(
                        'Brands with their models',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const BrandsWithModelsWidget(),
                      const Gap(height: 15),
                      Text(
                        'Model year',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const ModelYearWidget(),
                      const Gap(height: 15),
                      Text(
                        'Numbers of seats',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const SeatsWidget(),
                      const Gap(height: 15),
                      Text(
                        'Vehicle type',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const VehicleTypeWidget(),
                      const Gap(height: 15),
                      Text(
                        'Minimum age',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const MinimumAgeWidget(),
                      const Gap(height: 15),
                      Text(
                        'Rental period',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const RentalPeriod(),
                      const Gap(height: 15),
                      Text(
                        'Budget',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const DailyBudgetWidget(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     ConstrainedBox(
                      //       constraints: BoxConstraints(
                      //           maxHeight: 50.h, maxWidth: 140.w),
                      //       child: TextFormField(
                      //         controller: _dailyController,
                      //         keyboardType: TextInputType.number,
                      //         decoration: const InputDecoration(
                      //           labelText: 'Daily',
                      //           border: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //             color: GeneralData.borderColor,
                      //           )),
                      //         ),
                      //         onChanged: ((value) {}),
                      //       ),
                      //     ),
                      //     ConstrainedBox(
                      //       constraints: BoxConstraints(
                      //           maxHeight: 50.h, maxWidth: 140.w),
                      //       child: TextFormField(
                      //         controller: _monthlyController,
                      //         keyboardType: TextInputType.number,
                      //         decoration: const InputDecoration(
                      //           labelText: 'Monthly',
                      //           border: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //             color: GeneralData.borderColor,
                      //           )),
                      //         ),
                      //         onSaved: (newValue) {
                      //           print('changed');
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      const Gap(height: 15),
                      Text(
                        'Car featues',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 15),
                      const FeaturesWidget(),
                      const Gap(height: 15),
                      Text(
                        'Car colors',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const Gap(height: 5),
                      const CarColorsWidget(),
                    ],
                  ),
                )),
              ),
            ),
    );
  }
}
