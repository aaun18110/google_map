import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddCustomMarker extends StatefulWidget {
  const AddCustomMarker({super.key});

  @override
  State<AddCustomMarker> createState() => _AddCustomMarkerState();
}

class _AddCustomMarkerState extends State<AddCustomMarker> {
  Uint8List? imageMarker;

  final Completer<GoogleMapController> _controller = Completer();
  final cameraPosition = const CameraPosition(
      target: LatLng(30.805552389768945, 73.46285124789823), zoom: 16);

  List<String> images = [
    "assets/images/marker_1.png",
    "assets/images/marker_2.png",
    "assets/images/marker_3.png",
    "assets/images/marker_4.png",
    "assets/images/marker_5.png",
    "assets/images/marker_6.png",
    "assets/images/marker_7.png",
    "assets/images/marker_8.png"
  ];

  final List<Marker> _marker = [];
  final List<LatLng> _latLng = [
    const LatLng(30.80544180841749, 73.46227725516779),
    const LatLng(30.804962621090645, 73.46207340728222),
    const LatLng(30.806930646590168, 73.46004296167355),
    const LatLng(30.803936393666195, 73.46660062505556),
    const LatLng(30.805275847101797, 73.46151238977409),
    const LatLng(30.806354011712536, 73.46347576677728),
    const LatLng(30.808111628929147, 73.45775746921954),
    const LatLng(30.8046596774388, 73.46067923629863)
  ];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<Uint8List> getByteAssetIamges(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void loadImages() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List imageIcon = await getByteAssetIamges(images[i], 100);
      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(imageIcon),
          infoWindow: InfoWindow(title: "Index:$i"),
          position: _latLng[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_marker),
        initialCameraPosition: cameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController mController) {
          _controller.complete(mController);
        },
      ),
    );
  }
}
