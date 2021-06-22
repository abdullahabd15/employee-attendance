import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationUtil {

  static Future<String> getAddress(LatLng latLng) async {
    try {
      var coordinate = Coordinates(latLng.latitude, latLng.longitude);
      var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinate);
      var address = addresses.first;
      return address.addressLine;
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<LatLng> getCurrentLatLng() async {
    try {
      var location = await Location().getLocation();
      return LatLng(location.latitude, location.longitude);
    } catch (e) {
      print(e);
      return LatLng(0.0, 0.0);
    }
  }
}