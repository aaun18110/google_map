// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Utils/pages.dart';

class SeacrhPlaceApi extends StatefulWidget {
  const SeacrhPlaceApi({super.key});

  @override
  State<SeacrhPlaceApi> createState() => _SeacrhPlaceApiState();
}

class _SeacrhPlaceApiState extends State<SeacrhPlaceApi> {
  final Completer<GoogleMapController> _controller = Completer();
  final cameraPosition = const CameraPosition(
      target: LatLng(30.80531803404428, 73.46130558439981), zoom: 14);

  final List<Marker> _marker = [
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(30.80531803404428, 73.46130558439981),
      infoWindow: InfoWindow(title: "It's my Sahari Place."),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_marker),
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController moveController) {
              _controller.complete(moveController);
            },
          ),
          InkWell(
              onTap: () {
                print("Filter");
                Navigator.pushNamed(context, RouteName.filterPlaces);
              },
              child: const SearchBar()),
        ],
      ),
    );
  }
}

//Searchbar
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(28)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.location_on,
              size: 32,
              color: Colors.grey.shade400,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: SizedBox(
              height: 60,
              child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    "Search here",
                    style: TextStyle(fontSize: 22, color: Colors.grey.shade400),
                  )),
            )),
            Icon(
              Icons.mic,
              size: 32,
              color: Colors.grey.shade400,
            ),
            const SizedBox(
              width: 5,
            ),
            const CircleAvatar(
              backgroundColor: Colors.black45,
              child: Text(
                "A",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
