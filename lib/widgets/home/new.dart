import 'package:dream_access/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../providers/acceuil_provider.dart';
import 'cardetail/car_detail_home_widget.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  var _isLoading = false;
  var page = 1;
  final PagingController<int, Car> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.watch<AcceuilProvider>().paginationFct(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // final response = await get(Uri.parse(
      //     "https://jsonplaceholder.typicode.com/posts?_page=$pageKey&_limit=$_numberOfPostsPerRequest"));
      // List responseList = json.decode(response.body);
      // List<Post> postList = responseList
      //     .map((data) => Post(data['title'], data['body']))
      //     .toList();
      // final isLastPage = postList.length < _numberOfPostsPerRequest;
      // if (isLastPage) {
      //   _pagingController.appendLastPage(postList);
      // } else {
      //   final nextPageKey = pageKey + 1;
      //   _pagingController.appendPage(postList, nextPageKey);
      // }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.read<AcceuilProvider>();
    return Scaffold(
      body: PagedListView<int, dynamic>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
            itemBuilder: (context, item, index) {
          return Column(
            children: [
              CarDetailHomeWidget(car: item),
              if (index == _pagingController.itemList!.length - 1)
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text("No More Data"),
                ),
            ],
          );
        }),
      ),
    );
  }
}
