import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MySearchScreen extends StatefulWidget {
  @override
  _MySearchScreenState createState() => _MySearchScreenState();
}

class _MySearchScreenState extends State<MySearchScreen> {
  final FloatingSearchBarController _searchBarController =
      FloatingSearchBarController();

  List<String> _searchResults = [];

  void _getSearchResults(String query) async {
    final response =
        await http.get(Uri.parse('https://example.com/search?q=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _searchResults = List<String>.from(data['results']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFloatingSearchBar() as AppBar,
      body: Center(
        child: DropdownButton<String>(
          items: _searchResults
              .map((result) => DropdownMenuItem<String>(
                    value: result,
                    child: Text(result),
                  ))
              .toList(),
          onChanged: (selectedValue) {
            // Do something with the selected value
          },
        ),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      controller: _searchBarController,
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      width: 600,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        _getSearchResults(query);
      },
      // Specify the fields to display in each search result
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                  onTap: () {
                    _searchBarController.close();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
