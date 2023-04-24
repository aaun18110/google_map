// import 'package:flutter/material.dart';
// import 'package:flutter_geocoder/geocoder.dart';

// class ConvertLatiToLang extends StatefulWidget {
//   const ConvertLatiToLang({super.key});

//   @override
//   State<ConvertLatiToLang> createState() => _ConvertLatiToLangState();
// }

// class _ConvertLatiToLangState extends State<ConvertLatiToLang> {
//   String cityAdderss = '';
//   String cityCoordinates = '';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Latitude & Longitude convert to Address"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             RichText(
//                 text: TextSpan(
//                     text: "Address : ",
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                     children: [
//                   TextSpan(
//                       text: cityAdderss,
//                       style: const TextStyle(fontWeight: FontWeight.normal))
//                 ])),
//             const SizedBox(
//               height: 20,
//             ),
//             RichText(
//                 text: TextSpan(
//                     text: "Coordinates : ",
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                     children: [
//                   TextSpan(
//                       text: cityCoordinates,
//                       style: const TextStyle(fontWeight: FontWeight.normal))
//                 ])),
//             const SizedBox(
//               height: 10,
//             ),
//             Center(
//               child: GestureDetector(
//                 onTap: () async {
//                   const queery = "Okara Bypass Stop, Okara";
//                   var coordinates1 =
//                       await Geocoder.local.findAddressesFromQuery(queery);
//                   var second = coordinates1.first;
//                   print(
//                       "Coordinates : ${second.featureName}${second.coordinates}");

//                   final coordinates =
//                       Coordinates(30.793581016115013, 73.42162602498081);
//                   var address = await Geocoder.local
//                       .findAddressesFromCoordinates(coordinates);
//                   var convert = address.first;
//                   print(
//                       "Address : ${convert.featureName}${convert.addressLine}");
//                   setState(() {
//                     cityAdderss = convert.addressLine.toString();
//                     cityCoordinates = second.coordinates.toString();
//                   });
//                 },
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                       color: Colors.blue.shade700,
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(16),
//                           bottomRight: Radius.circular(16))),
//                   child: const Center(
//                     child: Text(
//                       "Convert",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
