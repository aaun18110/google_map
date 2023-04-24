import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowPolygons extends StatefulWidget {
  const ShowPolygons({super.key});

  @override
  State<ShowPolygons> createState() => _ShowPolygonsState();
}

class _ShowPolygonsState extends State<ShowPolygons> {
  final Completer<GoogleMapController> _polygonController = Completer();
  final cameraPosition = const CameraPosition(
      target: LatLng(30.815034633174317, 73.43510040769073), zoom: 12);

  final List<Marker> _marker = <Marker>[];

  List<LatLng> point = [
    const LatLng(30.81487441211368, 73.45261755219718),
    const LatLng(30.807072278440888, 73.44087944864796),
    const LatLng(30.805513224057265, 73.42272736258627),

    const LatLng(30.800901364924876, 73.44753839073097),

    const LatLng(30.780614470550756, 73.44909788516837),
    const LatLng(30.79462498757183, 73.46061839180297),
    const LatLng(30.781497145804398, 73.46877128852378),
    const LatLng(30.781134026887877, 73.46939849093995),
    const LatLng(30.800956003239897, 73.47219275436699),
    const LatLng(30.803949922207845, 73.49627468324223),
    const LatLng(30.806954573630982, 73.46429339762255),
    const LatLng(30.81487441211368, 73.45261755219718),
  ];
  final Set<Polygon> _polygon = HashSet<Polygon>();

  @override
  void initState() {
    super.initState();
    _polygon.add(Polygon(
        polygonId: const PolygonId('1'),
        points: point,
        fillColor: Colors.red.withAlpha(27),
        strokeWidth: 2,
        strokeColor: Colors.black,
        geodesic: true));
    load();
  }

  void load() {
    for (int i = 0; i < point.length; i++) {
      _marker.add(Marker(
        markerId: MarkerId(i.toString()),
        position: point[i],
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set<Marker>.of(_marker),
        polygons: _polygon,
        trafficEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _polygonController.complete(controller);
        },
      ),
    );
  }
}
