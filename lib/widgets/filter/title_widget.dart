import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/filter_provider.dart';
import '../../providers/search_by_filter_provider.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  var _isInit = true;
  var _isLoading = false;
  var _location = 'All cities';
  var _firstTime = true;
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     // print('Map : $_map');
  //     print('location: $_location');
  //     context.watch<AcceuilProvider>().acceuilFct({}).then((_) {}).then((_) {
  //           setState(() {
  //             _isLoading = false;
  //           });
  //         });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  void _clickFct(int stateID) {
    context.read<FilterProvider>().filterPressedFct(true);
    context.read<SearchByFilterProvider>().mapFct("state", stateID);
  }

  @override
  Widget build(BuildContext context) {
    var data = context.read<FilterProvider>();
    var listenData = context.watch<FilterProvider>();

    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.r,
            color: Colors.black,
          ),
        ),
        // const Spacer(),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              )),
              builder: (context) => StatefulBuilder(
                builder: ((context, setState) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: double.infinity,
                      // color: Colors.blue,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 16.h, left: 16.w),
                              child: Text(
                                'Location',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                            ...listenData.states.map((e) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _firstTime = false;
                                    });
                                    _clickFct(e.id);
                                    data.selectedStateFct(e);
                                    // setState(() {
                                    //   _location = e.name;
                                    //   // _map = {'state': '${e.id}'};
                                    //   context
                                    //       .read<AcceuilProvider>()
                                    //       .city(e.name);
                                    //   _isInit = true;
                                    // });
                                  },
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.place,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(e.name),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.place,
                size: 28.r,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                // width: 72.w,
                child: _firstTime
                    ? Text('All states',
                        style: Theme.of(context).textTheme.headline2)
                    : Text(listenData.location,
                        style: Theme.of(context).textTheme.headline2),
              ),
              // const Spacer(),
              Icon(Icons.expand_more, size: 24.r)
            ],
          ),
        ),

        // SizedBox(width: 75.w),
        // Expanded(
        //   child: Center(
        //     child: Text(
        //       'Filters',
        //       style: Theme.of(context)
        //           .textTheme
        //           .headline1!
        //           .copyWith(color: Theme.of(context).primaryColor),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
