// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapThemeStyling extends StatefulWidget {
  const MapThemeStyling({super.key});

  @override
  State<MapThemeStyling> createState() => _MapThemeStylingState();
}

class _MapThemeStylingState extends State<MapThemeStyling> {
  String sliverMode = '';
  final Completer<GoogleMapController> _themeController = Completer();
  final cameraPosition = const CameraPosition(
      target: LatLng(30.814668415342226, 73.45356799707359), zoom: 15);

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/theme/silver.json')
        .then((value) {
      sliverMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: cameraPosition,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(sliverMode);
            _themeController.complete(controller);
          },
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.9,
          left: MediaQuery.of(context).size.width * 0.8  ,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            child: PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text("Silver"),
                        onTap: () {
                          _themeController.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/theme/silver.json")
                                .then((silver) {
                              value.setMapStyle(silver);
                            });
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("Night"),
                        onTap: () {
                          _themeController.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/theme/night.json")
                                .then((night) {
                              value.setMapStyle(night);
                            });
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("Retro"),
                        onTap: () {
                          _themeController.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString("assets/theme/retro.json")
                                .then((retro) {
                              value.setMapStyle(retro);
                            });
                          });
                        },
                      )
                    ]),
          ),
        )
      ],
    ));
  }
}
