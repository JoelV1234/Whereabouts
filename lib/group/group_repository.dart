import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:location_sharing_app/group/models/group.dart';

class GroupRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> group(String groupId) => 
  FirebaseFirestore.instance.collection('groups').doc(groupId);

  final functions = FirebaseFunctions.instance.httpsCallable;

  DocumentReference<Map<String, dynamic>> userDoc(String userID) => 
  FirebaseFirestore.instance.collection('users').doc(userID);

  Future<void> removeMember(String uid, String groupId) =>
    functions('removeMember').call({
      "group" : groupId,
      "user" : uid
    });

  Future<void> deleteGroup(String groupId) =>
    functions('deleteGroup').call({
      "group" : groupId
    });

  Stream<Group> groupStream(String groupId) =>
    group(groupId).snapshots().map<Group>((event) => Group.fromJson(event.data()!, groupId));

  Future<Map<String, dynamic>> addGroup(String groupName, List<String> members) async {
    return functions('createGroup').call({"name" : groupName}).then((value) => 
    value.data as Map<String, dynamic>);
  }

  Future<void> joinGroup(String groupId) =>
    functions('addToGroup').call({"group" : groupId});

  Future<dynamic> inviteUsers(String groupId, List<String> members) =>
     functions('sendInvite').call({
      "group" : groupId,
      "users" : members
    });

  Future<dynamic> changeGroupName(String groupId, String name) =>
     functions('changeGroupName').call({
      "group" : groupId,
      "name" : name
    });

  
  Stream<List<Stream<Group>>> getGroups(String uid) =>
    firestore.collection('users/$uid/groups').doc('groups').snapshots().map(
    (snapshot) => snapshot.data()!.keys.map((key) => groupStream(key)).toList());

}