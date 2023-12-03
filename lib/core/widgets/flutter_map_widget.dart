import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/logic/address_provider.dart';
import 'package:flutter_application_1/core/logic/ads_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FlutterMapPage extends StatefulWidget {
  LatLongCenter center;
  FlutterMapPage({super.key, required this.center});

  @override
  State<FlutterMapPage> createState() => _FlutterMapPageState();
}

class LatLongCenter {
  LatLongCenter({
    required this.latitude,
    required this.longitude,
  });
  double latitude;
  double longitude;
}

class _FlutterMapPageState extends State<FlutterMapPage> {
  final MapController _mapController = MapController();
  // List<OSMData> _options = <OSMData>[];
  // Timer? _debounce;
  bool isProcess = false;
  double? numLat;
  double? numLng;
  String _displayName = 'MOVE POSITION';

  @override
  Widget build(BuildContext context) {
    var provAds = Provider.of<AdsProvider>(context);
    var provAddress = Provider.of<AddressProvider>(context);

    return Stack(children: [
      Positioned(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FlutterMap(
            options: MapOptions(
              initialCenter:
                  LatLng(widget.center.latitude, widget.center.longitude),
              initialZoom: 14,
              maxZoom: 18,
              minZoom: 6,
              // onMapCreated: (mapController) async {
              //   var response = await provAds.loadLatLong(
              //       numLat ?? widget.center.latitude,
              //       numLng ?? widget.center.longitude);
              //   try {
              //     print(response!.displayName);
              //     setState(() {
              //       _displayName = response.displayName;
              //     });
              //   } catch (e) {
              //     print('response null');
              //   }
              // },
              onPositionChanged: (position, hasGesture) async {
                if (!isProcess) {
                  isProcess = true;
                  Timer(const Duration(seconds: 2), () async {
                    numLat = position.center!.latitude;
                    numLng = position.center!.longitude;
                    print('$numLat,$numLng');
                    if (numLat != null && numLng != null) {
                      var response =
                          await provAds.loadLatLong(numLat!, numLng!);
                      try {
                        print(response!.displayName);
                        setState(() {
                          _displayName = response.displayName;
                        });
                      } catch (e) {
                        print('response null');
                      }
                      isProcess = false;
                    }
                  });
                }
              },
            ),
            mapController: _mapController,
            // layers: [
            //   TileLayerOptions(
            //       urlTemplate:
            //           "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            //       subdomains: ['a', 'b', 'c']),
            // ],
            children: [
              // TileLayerOptions(
              //     urlTemplate:
              //         "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              //     subdomains: ['a', 'b', 'c']),
            ],
          ),
        ),
      ),
      Center(
          child: Icon(
        Icons.location_pin,
        size: 50,
        color: Theme.of(context).colorScheme.primary,
      )),
      // Positioned(
      //     child: Container(
      //   padding: const EdgeInsets.all(8),
      //   decoration: const BoxDecoration(
      //     color: Colors.white,
      //   ),
      //   child: const TextField(
      //     decoration: InputDecoration(
      //         border: OutlineInputBorder(), fillColor: Colors.white),
      //   ),
      // )),
      Center(
        child: Text(
          (isProcess)
              ? (_displayName =
                  "(${numLat?.toStringAsFixed(4)},${numLng?.toStringAsFixed(4)})")
              : _displayName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // Positioned(
      //     top: 100,
      //     left: 8,
      //     right: 8,
      //     child: SingleChildScrollView(
      //       child: Container(
      //         height: MediaQuery.of(context).size.height * 0.3,
      //         decoration: const BoxDecoration(color: Colors.white),
      //         child: Column(
      //           children: [
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //             Text('data'),
      //           ],
      //         ),
      //       ),
      //     )),
      Positioned(
          left: MediaQuery.of(context).size.width * 0.2,
          bottom: 0,
          child: ElevatedButton(
            onPressed: () {
              provAddress.paramLang = numLat;
              provAddress.paramLong = numLng;
              provAddress.paramDisplayName = _displayName;
              provAddress.setMap();
              Navigator.pop(context);
            },
            child: const Text('Set Location'),
          ))
    ]);
  }
}
