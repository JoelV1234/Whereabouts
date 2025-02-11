import 'package:equatable/equatable.dart';

class Members with EquatableMixin{
  final bool isMember;
  final String uid;
  final DateTime? inviteSent;
  Members({
    required this.isMember, 
    required this.uid, 
    this.inviteSent
  });
  
  factory Members.fromJson(Map<String, dynamic> json, String uid) {
    return Members(
      isMember: json['member'],
      uid: uid,
      inviteSent: json['sent'] == null ? null : 
        DateTime.fromMillisecondsSinceEpoch(json['sent']),
    );
  }

  @override
  List<Object?> get props => [uid];
}