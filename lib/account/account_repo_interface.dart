import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/my_account.dart';

abstract class AccountRepoInterface {
  Stream<MyAccount> adminAccount(String uid);
  Stream<Account> peerAccount(String uid);
  Stream<Account> publicAccount(String uid);
  Future<void> updateGroupProfile(String uid, Map<String, dynamic> data);
  Future<List<Account>> getPublicAccounts(String handle);
  Future<void> updatePublicProfile(String uid, Map<String, dynamic> data);
  Stream<List<Account>> getPublicAccountsFromList(List<String> uids);
  Stream<List<Account>> getPeerAccountsFromList(List<String> uids);
}