import 'package:dream_access/widgets/filter/filter_pagination.dart';
import 'package:flutter/material.dart';

class FilterTest extends StatefulWidget {
  const FilterTest({super.key});

  @override
  State<FilterTest> createState() => _FilterTestState();
}

class _FilterTestState extends State<FilterTest> {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(child: FilterPagination()),
        ],
      ),
    );
  }
}
