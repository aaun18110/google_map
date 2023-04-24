import 'package:flutter/material.dart';
import 'package:google_map/Screens/home_screen.dart';
import 'package:google_map/Screens/map_theme.dart';
import 'package:google_map/Screens/netwok_images.dart';
import 'package:google_map/Screens/polygons.dart';
import 'package:google_map/Screens/polyines.dart';
import 'package:google_map/Utils/pages.dart';
import '../Screens/custom_infoWindow.dart';
import '../Screens/custom_marker.dart';
import '../Screens/filter_places.dart';
import '../Screens/get_user_location.dart';
import '../Model & View/search_place.dart';

class Routes {
  static Route<dynamic> generatesRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteName.customInfoWindow:
        return MaterialPageRoute(
            builder: (context) => const CustomInfoWindowMarker());
      case RouteName.getUserCurrentLocation:
        return MaterialPageRoute(
            builder: (context) => const GetUserCurrentLocation());
      case RouteName.filterPlaces:
        return MaterialPageRoute(builder: (context) => const FilterPlaces());
      case RouteName.customMarker:
        return MaterialPageRoute(builder: (context) => const AddCustomMarker());
      case RouteName.searchPlace:
        return MaterialPageRoute(builder: (context) => const SeacrhPlaceApi());
      case RouteName.polygonScreen:
        return MaterialPageRoute(builder: (context) => const ShowPolygons());
      case RouteName.polylineScreen:
        return MaterialPageRoute(builder: (context) => const PolylineScreen());
      case RouteName.mapTheme:
        return MaterialPageRoute(builder: (context) => const MapThemeStyling());
      case RouteName.networkImage:
        return MaterialPageRoute(
            builder: (context) => const NetworkImageScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold();
        });
    }
  }
}
