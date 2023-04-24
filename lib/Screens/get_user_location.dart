// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  final Completer<GoogleMapController> _getController = Completer();
  final cameraPosition =
      const CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);

  final List<Marker> _marker = [
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(title: "Multan Ghanta Ghar Chowk"),
    )
  ];

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error$error");
    });

    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _getController.complete(controller);
        },
        initialCameraPosition: cameraPosition,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserLocation().then((value) async {
            print("Current location :");
            print("${value.latitude} " "${value.longitude}");
            _marker.add(Marker(
              markerId: const MarkerId("2"),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(title: "My Current Location"),
            ));
            final cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14);
            GoogleMapController controller = await _getController.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.location_on_outlined),
      ),
    ));
  }
}
