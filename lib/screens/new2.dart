import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class New2 extends StatefulWidget {
  @override
  _New2State createState() => _New2State();
}

class _New2State extends State<New2> {
  @override
  void initState() {
    _getStateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 100, top: 100),
            child: Text(
              'KDTechs',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== State

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myState,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select State'),
                        onChanged: (newValue) {
                          setState(() {
                            _myState = newValue ?? '_myState1';
                            _getCitiesList();
                            print(_myState);
                          });
                        },
                        items: statesList.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']),
                                value: item['id'].toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myCity,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select City'),
                        onChanged: (newValue) {
                          setState(() {
                            _myCity = newValue ?? '_myCity';
                            print(_myCity);
                          });
                        },
                        items: citiesList?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['name']),
                                value: item['id'].toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API
  List statesList = [];
  String _myState = '';

  String stateInfoUrl = 'http://cleanions.bestweb.my/api/location/get_state';
  Future _getStateList() async {
    await http.post(Uri.parse(stateInfoUrl), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var data = json.decode(response.body);

//      print(data);
      setState(() {
        statesList = data['state'];
      });
    });
  }

  // Get State information by API
  List citiesList = [];
  String _myCity = '';

  String cityInfoUrl =
      'http://cleanions.bestweb.my/api/location/get_city_by_state_id';
  Future _getCitiesList() async {
    await http.post(Uri.parse(cityInfoUrl), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
      "state_id": _myState,
    }).then((response) {
      var data = json.decode(response.body);

      setState(() {
        citiesList = data['cities'];
      });
    });
  }
}
