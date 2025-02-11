import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';


class Sos {
  final String id;
  final String message;
  final String name;
  final String uid;
  final GeoFirePoint? location;
  final String? contact;
  final DateTime sent;

  Sos({
    required this.id,
    required this.message,
    required this.uid,
    required this.name,
    this.location,
    this.contact,
    required this.sent,
  });

  factory Sos.fromJson(Map<String, dynamic> json, String id) {
    Map<String, dynamic> info = json['info'];
    return Sos(
      id: id,
      sent: DateTime.fromMillisecondsSinceEpoch(json['updated']),
      message: info['message'],
      name: info['name'],
      uid: info['uid'],
      location: GeoFirePoint(
        GeoPoint(info['location'][0], info['location'][1])
      ),
      contact: info['contact'],
    );
  }
}