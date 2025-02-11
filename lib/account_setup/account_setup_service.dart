import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSetupService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String get email => auth.currentUser!.email!;

  Future<void> verifyEmail() async {
    await auth.currentUser!.sendEmailVerification();
  }

  Stream<bool> isEmailVerified() {
    return Stream.periodic(
      const Duration(seconds: 2),
      (_) => auth.currentUser!.emailVerified
    );
  }

  Future<String> createUserName(String username) async {
    final ref = firestore.collection('handles');
    final dataSnapshot = await ref.orderBy(username).get();
    if (dataSnapshot.docs.isNotEmpty) {
      throw Exception('Username already exists');
    } else {
      await ref.doc('user_handles').update({
        username: auth.currentUser!.uid
      });
    }
    return username;
  }

  Future<void> updateInfo(String? phone, String? displayName) async {
    final groupRef = firestore.collection('users').doc(auth.currentUser!.uid);
  
    await groupRef.update({'phone': phone });
    await firestore.collection(
      'users/${auth.currentUser!.uid}/access').doc('public').
      update({'name': displayName});
  }

  Future<void> createUser(String username) async {
    await FirebaseFunctions.instance.httpsCallable('createNewUser').call({
      "username" : username
    });
  }
}