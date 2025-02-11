import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/account_repository.dart';
import 'package:location_sharing_app/group/group_repository.dart';
import 'package:location_sharing_app/group/models/members.dart';
import 'package:rxdart/rxdart.dart';

class Group {
  final GroupRepository groupService = GroupRepository();
  final String groupId;
  final String name;
  final String owner;
  final List<Members> members;
  AccountRepository accountRepo = AccountRepository();

  Group({
    required this.groupId, 
    required this.name, 
    required this.owner, 
    required this.members,
  });

  factory Group.fromJson(
    Map<String, dynamic> json, 
    String groupId,
  ) {
    return Group(
      groupId: groupId,
      name: json['name'],
      owner: json['owner'],
      members: json['members'].entries.map<Members>((e) => 
      Members.fromJson(e.value, e.key)).toList()
    );
  }

  List<String> getMembersUids() => members.where(
    (member) => member.isMember).map((member) => member.uid).toList();
  List<String> getInvitedUids() => members.where(
    (member) => !member.isMember).map((member) => member.uid).toList();

  bool isMember(String uid) =>
    members.where(
      (member) => member.uid == uid && member.isMember).isNotEmpty;

  Future<void> deleteGroup() => groupService.deleteGroup(groupId);

  Future<dynamic> inviteUsers( Set<Account> members) => 
  groupService.inviteUsers(groupId, members.map((account) => account.uid).toList());


  Stream<List<Account>> getMembersStream() => CombineLatestStream.combine2(
    accountRepo.getPublicAccountsFromList(getInvitedUids()), 
    accountRepo.getPeerAccountsFromList(getMembersUids()), 
    (streamOne, streamTwo) => [...streamOne, ...streamTwo]
  );

  Stream<List<Account>> getAccounts(List<String> uids) => 
    accountRepo.getPeerAccountsFromList(uids);
  
  Stream<List<Account>> getMembersPublicAccounts() =>
    accountRepo.getPublicAccountsFromList(
      members.map((member) => member.uid).toList());

  Future<void> changeGroupName(String name) => groupService.changeGroupName(groupId, name);
  Future<void> removeMember(String uid) => groupService.removeMember(uid, groupId);
  Future<void> acceptInvite() => groupService.joinGroup(groupId);
}