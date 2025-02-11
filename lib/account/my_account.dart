import 'dart:async';

import 'package:location/location.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/account_repository.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/group_repository.dart';
import 'package:location_sharing_app/location/location_repo.dart';
import 'package:location_sharing_app/sos/sos.dart';

import '../sos/alert_repo.dart';

class MyAccount extends Account {
  final Map<String, dynamic> groups;
  final List<Sos> alerts;
  final AccountRepository accountRepo = AccountRepository();
  final GroupRepository groupRepo = GroupRepository();
  final LocationRepository locationRepo = LocationRepository();
  final AlertRepository alertRepo = AlertRepository();

  MyAccount({
    required this.alerts,
    required this.groups,
    required super.uid, 
    required super.email, 
    required super.username, 
    super.photourl, 
    super.displayname, 
    super.phonenumber
  });
  
  factory MyAccount.fromJson(
    Map<String, dynamic> json, 
    Map<String, dynamic> groupsJson, 
    List<Sos> alerts,
    String uid
  ) {
    return MyAccount(
      alerts: alerts,
      groups: groupsJson,
      uid: uid,
      email: json['email'],
      username: json['username'],
      photourl: json['pictureurl'],
      displayname: json['displayname'],
      phonenumber: json['phone'],
    );
  }

  Stream<List<Stream<Group>>> getGroups() => groupRepo.getGroups(uid);

  List<Stream<Group>> getGroupsList() => 
    groups.entries.map(
      (entry) => groupRepo.groupStream(entry.key)).toList();

  Future<void> updateProfile(Map<String, dynamic> data) =>
    accountRepo.updateGroupProfile(uid, data); 
  
  Future<void> updatePhoneNumber(String phone) =>
    accountRepo.updateGroupProfile(uid, {
      'phone' : phone
    });

  Future<void> changeDisplayName(String name) =>
    accountRepo.updatePublicProfile(uid, {
      'displayname': name
    });
  
  Future<void> sendEmergencyMessage(String message) async{
    LocationData location = await Location().getLocation();
    return alertRepo.sendEmergencyMessage(
      message, displayname ?? username, 
      phonenumber ?? email!, location);
  }

  Future<void> seenAlerts() => alertRepo.seenAlerts(uid);

  Stream<List<Sos>> getAlerts() => alertRepo.alertStream(uid);
  Stream<List<Sos>> getNotification() => accountRepo.notificationStream(uid);

  void updateLocation() {
    Location location = Location();
      location.getLocation().then((locationData) =>
      locationRepo.updateUserLocation(
        this, locationData));
  }

}