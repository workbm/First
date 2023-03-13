import 'package:dream_access/models/car.dart';
import 'package:dream_access/providers/new3_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import 'widgets/home/cardetail/car_detail_home_widget.dart';

class New4 extends StatefulWidget {
  const New4({super.key});

  @override
  State<New4> createState() => _New4State();
}

class _New4State extends State<New4> {
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
      await context.read<New3Provider>().paginationFct(pageKey).then(
        (_) {
          if (context.read<New3Provider>().lastPage == pageKey) {
            _pagingController.appendLastPage(context.read<New3Provider>().cars);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(
                context.read<New3Provider>().cars, nextPageKey);
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
    return PagedListView<int, Car>(
      // physics: NeverScrollableScrollPhysics(),
      // primary: false,
      // shrinkWrap: true,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Car>(
        itemBuilder: (context, item, index) => CarDetailHomeWidget(car: item),
      ),
    );
  }
}



   //  Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Blog App"),
    //     centerTitle: true,
    //   ),
    //   body:
    //    RefreshIndicator(
    //     onRefresh: () => Future.sync(() => _pagingController.refresh()),
    //     child: PagedListView<int, Car>(
    //       pagingController: _pagingController,
    //       builderDelegate: PagedChildBuilderDelegate<Car>(
    //         itemBuilder: (context, item, index) => Padding(
    //           padding: const EdgeInsets.all(15.0),
    //           child: CarDetailHomeWidget(car: item),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
 
