import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';


class UserChip extends StatelessWidget {
  final Account account;
  final VoidCallback onDelete;
  const UserChip({super.key, required this.account, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InputChip(
      onPressed: onDelete,
      avatar: CircleAvatar(
         backgroundImage: NetworkImage(account.photourl ?? ''),
      ),
      label: Row(
        children: [
          Text(account.displayname ?? 'No name'),
          SizedBox(width: 7,),
          Icon(Icons.cancel, color: Colors.red, size: 20,)
        ],
      ),
    );
  }
}