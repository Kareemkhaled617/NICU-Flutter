import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'helper_location.dart';

class MapFileRun extends StatefulWidget {
  const MapFileRun({Key? key}) : super(key: key);

  @override
  State<MapFileRun> createState() => _MapFileRunState();
}

class _MapFileRunState extends State<MapFileRun> {
  static Position? position;
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _myCameraPosition = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    bearing: 0.0,
    zoom: 17,
    tilt: 0.0,
  );
  //

  Future<void> getMyCurrentLocation() async {
    await LocationHelper.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });
  }

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> goToMyCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToMyCurrentPosition,
        child: const Icon(
          Icons.place,
          color: Colors.white,
        ),
      ),
    );
  }
}
