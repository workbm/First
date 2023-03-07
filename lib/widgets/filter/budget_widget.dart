import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/search_by_filter_provider.dart';

class DailyBudgetWidget extends StatefulWidget {
  const DailyBudgetWidget({super.key});

  @override
  State<DailyBudgetWidget> createState() => _DailyBudgetWidgetState();
}

class _DailyBudgetWidgetState extends State<DailyBudgetWidget> {
  final _key = GlobalKey<FormState>();
  final _dailyController = TextEditingController();
  final _monthlyController = TextEditingController();
  var _isDailyClicked = false;
  var _isMonthlyClicked = false;

  @override
  void dispose() {
    _dailyController.dispose();
    _monthlyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 50.h, maxWidth: 140.w),
            child: TextFormField(
              controller: _dailyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Daily',
                suffix: _isDailyClicked
                    ? Text(
                        'AED',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 12),
                      )
                    : const SizedBox(),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: GeneralData.borderColor,
                )),
              ),
              onTap: () {
                setState(() {
                  _isDailyClicked = true;
                });
              },
              onChanged: (value) {
                print('changes 11');
                context.read<SearchByFilterProvider>().mapFct(
                      "day_budget",
                      int.parse(_dailyController.text),
                    );
              },
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 50.h, maxWidth: 140.w),
            child: TextFormField(
              controller: _monthlyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monthly',
                suffix: _isMonthlyClicked
                    ? Text(
                        'AED',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 12),
                      )
                    : const SizedBox(),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: GeneralData.borderColor,
                )),
              ),
              onTap: () {
                setState(() {
                  _isMonthlyClicked = true;
                });
              },
              onChanged: (value) {
                print('changes');
                context.read<SearchByFilterProvider>().mapFct(
                      "month_budget",
                      int.parse(_monthlyController.text),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
