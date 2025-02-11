import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';



class LocationPoint with EquatableMixin{
  final GeoFirePoint location;
  final String name;
  final String uid;
  LocationPoint({
    required this.location, 
    required this.name, 
    required this.uid
  });
  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    GeoPoint pos = json['location']['geopoint'];
    return LocationPoint(
      location: GeoFirePoint(pos),
      name: json['name'],
      uid: json['uid']
    );
  }
  
  @override
  List<Object?> get props => [uid];
}