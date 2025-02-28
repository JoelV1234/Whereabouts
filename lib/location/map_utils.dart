import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> markers) {
    double minLat = 0; 
    double maxLat = 0;
    double minLng = 0;
    double maxLng = 0;

    for (var marker in markers) {
      if (marker.latitude < minLat) {
        minLat = marker.latitude;
      }
      if (marker.latitude > maxLat) {
        maxLat = marker.latitude;
      }
      if (marker.longitude < minLng) {
        minLng = marker.longitude;
      }
      if (marker.longitude > maxLng) {
        maxLng = marker.longitude;
      }
    }
    
    print("===============");
  //  49.2641267, -122.817405
    print(markers);
    return LatLngBounds(
      northeast: LatLng(49.2641267 + 20, -122.817405 + 20),
      southwest: LatLng(49.2641267 - 20, -122.817405 - 20),
    );
  }
} 