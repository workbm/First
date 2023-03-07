import 'package:dream_access/providers/search_by_filter_provider.dart';
import 'package:dream_access/screens/filter/filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/home/cardetail/car_detail_home_widget.dart';

class FilteredCars extends StatefulWidget {
  const FilteredCars({super.key});

  @override
  State<FilteredCars> createState() => _FilteredCarsState();
}

class _FilteredCarsState extends State<FilteredCars> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      context
          .watch<SearchByFilterProvider>()
          .searchByFilterFct(1)
          .then((value) {
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
    var listenData = context.watch<SearchByFilterProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context, true);
                // push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const FilterScreen(),
                //     ));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Filtered cars',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.red, size: 50.r))
          : SafeArea(
              child: listenData.cars.isEmpty
                  ? Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              const Text('Unfortunately, there are no cars')),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ...listenData.cars.map(
                            (e) => CarDetailHomeWidget(car: e),
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }
}
