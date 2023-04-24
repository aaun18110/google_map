import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageScreen extends StatefulWidget {
  const NetworkImageScreen({super.key});

  @override
  State<NetworkImageScreen> createState() => _NetworkImageScreenState();
}

class _NetworkImageScreenState extends State<NetworkImageScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final cameraPosition = const CameraPosition(
      target: LatLng(30.814141152915326, 73.45275542766271), zoom: 14);

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latLang = [
    const LatLng(30.814141152915326, 73.45275542766271),
    const LatLng(30.80868622439466, 73.43918658016379),
    const LatLng(30.81463704014919, 73.43261868057654),
    const LatLng(30.826947226434328, 73.4461267851682)
  ];

  final List<String> netImages = [
    'https://png.pngtree.com/png-clipart/20221207/ourmid/pngtree-business-man-avatar-png-image_6514640.png',
    'https://png.pngtree.com/png-clipart/20221207/ourmid/pngtree-fashion-boy-avatar-png-image_6514592.png',
    'https://static.vecteezy.com/system/resources/previews/010/871/103/original/3d-avatar-dj-png.png',
    'https://cdn3d.iconscout.com/3d/premium/thumb/young-businessman-avatar-5692602-4743371.png'
  ];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  void loadImages() async {
    for (int i = 0; i < netImages.length; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://static.vecteezy.com/system/resources/previews/010/871/103/original/3d-avatar-dj-png.png');
      final ui.Codec imageMarkerCodec = await ui.instantiateImageCodec(
          image!.buffer.asUint8List(),
          targetHeight: 150,
          targetWidth: 150);
      final ui.FrameInfo frameInfo = await imageMarkerCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List resizeIamgeMarker = byteData!.buffer.asUint8List();

      _marker.add(Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(resizeIamgeMarker),
          position: _latLang[i],
          infoWindow: InfoWindow(title: i.toString())));
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
    );
  }
}
