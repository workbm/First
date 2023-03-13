import 'package:dream_access/new4.dart';
import 'package:flutter/material.dart';

class PaginationTest extends StatefulWidget {
  const PaginationTest({super.key});

  @override
  State<PaginationTest> createState() => _PaginationTestState();
}

class _PaginationTestState extends State<PaginationTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('kkkk')),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                        title: Text('Item $index'),
                      ),
                      childCount: 10,
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: New4(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
