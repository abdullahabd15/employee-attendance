import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationUtil {

  static Future<String> getAddress(LatLng latLng) async {
    var coordinate = Coordinates(latLng.latitude, latLng.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinate);
    var address = addresses.first;
    return address.addressLine;
  }

  static Future<LatLng> getCurrentLatLng() async {
    var location = await Location().getLocation();
    return LatLng(location.latitude, location.longitude);
  }
}