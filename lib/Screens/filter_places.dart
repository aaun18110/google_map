// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class FilterPlaces extends StatefulWidget {
  const FilterPlaces({super.key});

  @override
  State<FilterPlaces> createState() => _FilterPlacesState();
}

class _FilterPlacesState extends State<FilterPlaces> {
  TextEditingController searchController = TextEditingController();
  String _sessionToken = '12345';
  // Uuid use of get mobile id
  var uuid = const Uuid();

  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    return getSuggestion(searchController.text);
  }

  void getSuggestion(String input) async {
    String kplacesApiKey = "AIzaSyDosoBDTg3w0NByDnxKzelFbVhX_AXxjeQ";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.grey.shade500)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 28,
                          color: Colors.grey.shade400,
                        )),
                    Expanded(
                        child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "Search here",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.grey.shade400, fontSize: 22)),
                      ),
                    )),
                    Icon(
                      Icons.mic,
                      size: 28,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on,
                            size: 28,
                            color: Colors.grey.shade500,
                          ),
                          title: Text(
                            _placeList[index]['description'],
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
