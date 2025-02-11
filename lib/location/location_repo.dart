import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:location/location.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/location/location_point.dart';
import 'package:rxdart/rxdart.dart';

class LocationRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference locationRef(String uid) => firestore.collection(
    'users/$uid/location_data').doc('location');
  
  Future<void> updateUserLocation(Account account, LocationData location) =>
    locationRef(account.uid).update({ 'uid' : account.uid,
        'timestamp': Timestamp.now(), 'name': account.displayname,
        'location': GeoFirePoint(GeoPoint(location.latitude!, location.longitude!)).data
      });   
  


  Stream<List<LocationPoint>> getUserPoint(List<String> uids) =>
    CombineLatestStream(
      uids.map((uid) => locationRef(uid).snapshots()).toList(),
      (values) => values.map<LocationPoint>((value) {
        return LocationPoint.fromJson(value.data()! as Map<String, dynamic>);
      }).toList()
    );
}