import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(
        30.805399205392096,
        73.46270768123968,
      ),
      zoom: 14);

  //Add Marker or pin your location on Map
  final List<Marker> _marker = [];
  final List<Marker> _list = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(
          30.805399205392096,
          73.46270768123968,
        ),
        infoWindow: InfoWindow(title: "Sabar Pia Town")),
    const Marker(
        markerId: MarkerId("2"),
        position: LatLng(30.805312642032348, 73.46144799498487),
        infoWindow: InfoWindow(title: "Nadir Hotel")),
    const Marker(
        markerId: MarkerId("3"),
        position: LatLng(30.87824111517865, 73.59542239614746),
        infoWindow: InfoWindow(title: "My university")),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
            compassEnabled: false,
            trafficEnabled: true,
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            initialCameraPosition: _cameraPosition),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            GoogleMapController clickController = await _mapController.future;
            clickController.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(30.87824111517865, 73.59542239614746),
                    zoom: 14)));
            setState(() {});
          },
          child: const Icon(Icons.location_disabled_rounded),
        ),
      ),
    );
  }
}
