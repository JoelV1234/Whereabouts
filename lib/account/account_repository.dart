import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/account_repo_interface.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/sos/alert_repo.dart';
import 'package:location_sharing_app/sos/sos.dart';
import 'package:rxdart/rxdart.dart';


class AccountRepository implements AccountRepoInterface {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> userDocRef(String userID) => 
 firestore.collection('users').doc(userID);

  DocumentReference<Map<String, dynamic>> publicDocRef(String userID) => 
 firestore.collection('users/$userID/access').doc('public');

  DocumentReference<Map<String, dynamic>> groupsDoc(String uid) =>
    firestore.collection('users/$uid/groups').doc('groups');

  DocumentReference<Map<String, dynamic>> notifDoc(String uid) =>
    firestore.collection('users/$uid/notifications').doc('alerts');

  static Stream<DocumentSnapshot<Map<String, dynamic>>> userDoc(String uid) =>
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

  Stream<List<Sos>> notificationStream(String uid) =>
    firestore.collection('users/$uid/notifications').doc('read').snapshots()
    .map<List<Sos>>((event) => (event.data()!.entries).map((e) => 
      Sos.fromJson(e.value, e.key)).toList());

  @override
  Stream<MyAccount> adminAccount(String uid)  {
    return CombineLatestStream.combine3(
      userDocStream(uid), 
      groupsDoc(uid).snapshots(),
      AlertRepository().alertStream(uid),
      (user, groups, alerts) => 
      MyAccount.fromJson(user, groups.data() ?? {}, alerts, uid,)
    );
  }

  @override
  Stream<Account> peerAccount(String uid) =>
    userDocStream(uid).map<Account>((event) => Account.fromJson(event, uid));

  @override
  Stream<Account> publicAccount(String uid) =>
    publicDocRef(uid).snapshots().map<Account>(
      (event) => Account.fromJson(event.data()!, uid));

  @override
  Future<void> updateGroupProfile(String uid, Map<String, dynamic> data) =>
    userDocRef(uid).update(data);

  @override
  Future<void> updatePublicProfile(String uid, Map<String, dynamic> data) =>
    publicDocRef(uid).update(data);


  @override
  Future<List<Account>> getPublicAccounts(String handle) async {
    final ref = await firestore.collectionGroup('access').where('username', isGreaterThanOrEqualTo: handle)
    .where('username', isLessThanOrEqualTo: '$handle\uf8ff').get();
    return ref.docs.map((doc) => Account.fromJson(doc.data())).toList();
  }

  @override
  Stream<List<Account>> getPublicAccountsFromList(List<String> uids) =>
    uids.isEmpty ? Stream.value([]):  CombineLatestStream(
      uids.map((key) => publicAccount(key)).toList(),
      (values) => values);

  @override
  Stream<List<Account>> getPeerAccountsFromList(List<String> uids) =>
      uids.isEmpty ? Stream.value([]) : CombineLatestStream(
      uids.map((key) => peerAccount(key)).toList(),
      (values) => values);

  Stream<Map<String, dynamic>> userDocStream(String uid)  {
    final publicDoc = publicDocRef(uid).snapshots();
    return CombineLatestStream.combine2(userDoc(uid), publicDoc, (a, b) =>
      {...a.data() ?? {}, ...b.data() ?? {} });
  }
}