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

  static void zoomToFit(GoogleMapController controller, LatLngBounds bounds,
      LatLng centerBounds) async {
    bool keepZoomingOut = true;

    while (keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if (isFitToScreen(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - 0.5;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      } else {
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  static LatLng getCenterBounds(LatLngBounds latLngBound) {
    return LatLng(
      (latLngBound.northeast.latitude + latLngBound.southwest.latitude) / 2,
      (latLngBound.northeast.longitude + latLngBound.southwest.longitude) / 2,
    );
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

  static bool isFitToScreen(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
  }
}
