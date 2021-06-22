import 'package:employee_attendance/util/image_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtil {
  static Future<Marker> createMarker(
      LatLng latLng, String markerId, String title, String info) async {
    var iconMarker = BitmapDescriptor.fromBytes(
        await ImageUtil.getBytesFromAsset('assets/images/map_marker.png', 150));
    var marker = Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        icon: iconMarker,
        infoWindow: InfoWindow(title: '$title :', snippet: info));
    return marker;
  }

  static LatLngBounds getLatLngBounds(LatLng latLngIn, LatLng latLngOut) {
    return LatLngBounds(
      southwest: LatLng(
          latLngIn.latitude <= latLngOut.latitude
              ? latLngIn.latitude
              : latLngOut.latitude,
          latLngIn.longitude <= latLngOut.longitude
              ? latLngIn.longitude
              : latLngOut.longitude),
      northeast: LatLng(
          latLngIn.latitude <= latLngOut.latitude
              ? latLngOut.latitude
              : latLngIn.latitude,
          latLngIn.longitude <= latLngOut.longitude
              ? latLngOut.longitude
              : latLngIn.longitude),
    );
  }
}
