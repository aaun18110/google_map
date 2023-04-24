import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _polylineController = Completer();
  final cameraPosition = const CameraPosition(
    target: LatLng(30.837222209005592, 73.50455142778065),
    zoom: 12,
  );
  final Set<Marker> _marker = {};
  final Set<Polyline> _ploy = {};
  final List<LatLng> _point = [
    const LatLng(30.837222209005592, 73.50455142778065),
    const LatLng(30.832358113396875, 73.49871494076369),
    const LatLng(30.82778858692897, 73.4901318716211),
    const LatLng(30.816290106660972, 73.49528171310666),
    const LatLng(30.8167323813598, 73.48017551141567),
    const LatLng(30.809065998318722, 73.46472598695897),
    const LatLng(30.80110410688387, 73.45339633569074),
    const LatLng(30.79476361045813, 73.42095233433169)
  ];

  @override
  void initState() {
    super.initState();
    loadPolyLine();
  }

  void loadPolyLine() {
    for (int i = 0; i < _point.length; i++) {
      _marker.add(Marker(
          markerId: const MarkerId('1'),
          position: _point[i],
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: i.toString(), snippet: "5 Stars")));

      _ploy.add(Polyline(
        polylineId: const PolylineId('1'),
        points: _point,
        color: Colors.blue,
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: _marker,
        polylines: _ploy,
        mapType: MapType.none,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _polylineController.complete(controller);
        },
      ),
    );
  }
}
