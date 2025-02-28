import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_sharing_app/location/location_point.dart';
import 'package:location_sharing_app/location/location_repo.dart';
import 'package:location_sharing_app/widgets/stream_widget.dart';


class MapScreen extends StatefulWidget {
  final List<String> uids;
  const MapScreen({super.key, required this.uids});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> mapController = Completer();
  bool isLoading = true;
  Location location = Location();
  final LatLng _center = const LatLng(45.521563, -122.677433);
  Set<LocationPoint> locations = {};
  late Stream<List<LocationPoint>> locationsStream;
  Future<void> mapBounds = Future.value();
  List<LocationPoint> points = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }


  void setLocationStream() async{
    locationsStream = LocationRepository().getUserPoint(
      widget.uids
    ).asBroadcastStream();
    points = await locationsStream.first;
  }

  @override
  void initState() {
    setLocationStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          StreamWidget<List<LocationPoint>>(
            stream: locationsStream,
            onData: (data) => GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  compassEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 0,
                    ),
                    markers: data.map((locationPoint) { 
                      GeoFirePoint location = locationPoint.location;
                      return Marker(
                        markerId: MarkerId(locationPoint.name),
                        position: LatLng(location.latitude, location.longitude),
                        infoWindow: InfoWindow(
                          title: locationPoint.name
                        )
                      );
                  }).toSet()
              ),
          ),
        //  isLoading ? LinearProgressIndicator() : Container()
      
        ],
      ),
    );
  }
}