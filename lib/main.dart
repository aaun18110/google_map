import 'package:flutter/material.dart';
import 'Utils/pages.dart';
import 'Utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const SeacrhPlaceApi(),
      initialRoute: RouteName.networkImage,
      onGenerateRoute: Routes.generatesRoute,
    );
  }
}
