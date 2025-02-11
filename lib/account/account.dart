
import 'package:equatable/equatable.dart';

class Account with EquatableMixin {
  final String uid;
  final String? email;
  final String username;
  final String? displayname;
  final String? photourl;
  final String? phonenumber;

  Account({
    required this.uid,
    this.email,
    required this.username,
    this.photourl,
    this.phonenumber,
    this.displayname
  });

  factory Account.fromJson(Map<String, dynamic> json, [String? uid]) {
    return Account(
      uid: uid ?? json['uid'],
      email: json['email'],
      username: json['username'],
      photourl: json['pictureurl'],
      displayname: json['displayname'],
      phonenumber: json['phone'],
    );
  }

  @override
  List<Object?> get props => [uid, displayname];
}