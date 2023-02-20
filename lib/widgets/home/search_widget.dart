import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../constants/general_data.dart';
import '../../providers/search_provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _key = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listenData = context.watch<SearchProvider>();
    var data = context.read<SearchProvider>();

    return Form(
      key: _key,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: GeneralData.width),
        child: CupertinoSearchTextField(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(),
          ),
          controller: _searchController,
          onSuffixTap: () {
            print('object cancel');
            _searchController.text = '';
            data.searchPressedFct(false);
          },
          onChanged: (value) {
            // _alphabetSearch = value;
            // print('_alphabetSearch:${_alphabetSearch}');
            // print('this $_alphabetSearch');
            print('_alphabetSearch:${_searchController.text}');
            // print('this $_alphabetSearch');
            if (_searchController.text.length > 1) {
              data.searchPressedFct(true);
              data.searchFct(_searchController.text);
            }
            // if (_alphabetSearch.isEmpty) {
            //   setState(() {});
            // }
          },
        ),
      ),
    );
  }
}
