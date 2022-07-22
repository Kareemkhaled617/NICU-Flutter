// for get current location

import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print(isServiceEnabled);

    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
      //for get permission from user to get current location
    } else if (isServiceEnabled) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,

      );
    }


  }
}

