import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/group/group_status_chip.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class UserTile extends StatelessWidget {
  final Account account;
  final bool isSelected;
  final bool isMember;
  final bool isOwner;
  final void Function(bool) onSelected;
  const UserTile({super.key, 
  this.isOwner = false,
  required this.account, 
  this.isMember = false,
  this.isSelected = false, 
  required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(account.photourl ?? ''),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText( fontSize: 15,
                account.displayname ?? 'No name', fontWeight: FontWeight.w500),
              CustomText(account.username)
            ],
          ),
          Expanded(child: Container()),
          (isMember || isOwner) ? GroupStatusChip(
            status: 'Member', isOwner: isOwner
          ) : RoundCheckBox(
            isChecked: isSelected,
            animationDuration: const Duration(milliseconds: 100),
            checkedWidget: const Icon(
              size: 20,
              Icons.check,  
              color: Colors.white,
            ),
            onTap: (value) => onSelected(value ?? false), size: 30),
        ],
      ),
    );
  }
}