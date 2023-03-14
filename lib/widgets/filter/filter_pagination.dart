import 'package:dream_access/providers/search_by_filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../models/car.dart';
import '../home/cardetail/car_detail_home_widget.dart';

class FilterPagination extends StatefulWidget {
  const FilterPagination({super.key});

  @override
  State<FilterPagination> createState() => _FilterPaginationState();
}

class _FilterPaginationState extends State<FilterPagination> {
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
          .read<SearchByFilterProvider>()
          .searchByFilterFct(pageKey)
          .then(
        (_) {
          if (context.read<SearchByFilterProvider>().lastPage == pageKey) {
            _pagingController
                .appendLastPage(context.read<SearchByFilterProvider>().cars);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(
                context.read<SearchByFilterProvider>().cars, nextPageKey);
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
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Car>(
        itemBuilder: (context, item, index) => CarDetailHomeWidget(car: item),
      ),
    );
  }
}
