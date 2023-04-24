import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class CustomInfoWindowMarker extends StatefulWidget {
  const CustomInfoWindowMarker({super.key});

  @override
  State<CustomInfoWindowMarker> createState() => _CustomInfoWindowMarkerState();
}

class _CustomInfoWindowMarkerState extends State<CustomInfoWindowMarker> {
  final cameraPosition = const CameraPosition(
      target: LatLng(30.80531720156905, 73.46154683525663), zoom: 15);
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _marker = [];
  final List<LatLng> _latLan = [
    const LatLng(30.805275847101797, 73.46151238977409),
    const LatLng(30.806354011712536, 73.46347576677728),
    const LatLng(30.808111628929147, 73.45775746921954),
    const LatLng(30.8046596774388, 73.46067923629863)
  ];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    for (int i = 0; i < _latLan.length; i++) {
      if (i % 2 == 0) {
        _marker.add(Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLan[i],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue,
                            child: Text(
                              "H",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text("Maxican Hotel"), Text("3Km")],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Center(
                          child: Text(
                              "A hotel is a commercial establishment that provides lodging, meals, and other services to guests, travelers, and tourists. "),
                        ),
                      )
                    ],
                  ),
                ),
                _latLan[i],
              );
            }));
      } else {
        _marker.add(Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLan[i],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 120,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.medium,
                                image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwEHz7biOXHQC3i_C3nRPLDCGBDIZWShB3KA&usqp=CAU"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [Text("Maxican Hotel"), Text("3Km")],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Center(
                          child: Text(
                              "A hotel is a commercial establishment that provides lodging, meals, and other services to guests, travelers, and tourists. "),
                        ),
                      )
                    ],
                  ),
                ),
                _latLan[i],
              );
            }));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: cameraPosition,
          onTap: (position) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
          },
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _customInfoWindowController.googleMapController = controller;
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          width: 200,
          height: 280,
          offset: 30,
        )
      ],
    ));
  }
}
