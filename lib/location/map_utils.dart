import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> markers) {
    double? minLat, maxLat, minLng, maxLng;

    for (var marker in markers) {
      if (minLat == null || marker.latitude < minLat) {
        minLat = marker.latitude;
      }
      if (maxLat == null || marker.latitude > maxLat) {
        maxLat = marker.latitude;
      }
      if (minLng == null || marker.longitude < minLng) {
        minLng = marker.longitude;
      }
      if (maxLng == null || marker.longitude > maxLng) {
        maxLng = marker.longitude;
      }
    }

    return LatLngBounds(
      northeast: LatLng(maxLat!, maxLng!),
      southwest: LatLng(minLat!, minLng!),
    );
  }
} 