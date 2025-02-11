import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_sharing_app/sos/sos.dart';

class AlertRepository {

  final functions = FirebaseFunctions.instance;
  DocumentReference<Map<String, dynamic>> alertDoc(String uid) =>
    FirebaseFirestore.instance.collection('users/$uid/notifications').doc('alerts');

  Future<void> seenAlerts(String uid) async => 
    functions.httpsCallable('seenAlert').call({});

  Stream<List<Sos>> alertStream(String uid) => 
    alertDoc(uid).snapshots().map<List<Sos>>((event) => 
      (event.data()!.entries).map((e) => Sos.fromJson(e.value, e.key)
    ).toList());

  Future<void> sendEmergencyMessage(
    String message,
    String name,
    String contact,
    LocationData location
  ) async =>
    await FirebaseFunctions.instance.httpsCallable('sendAlert').call({
      "message" : message,
      "name" : name,
      "location" : LatLng(location.latitude!, location.longitude!).toJson(),
      "contact" : contact
    });
    
}