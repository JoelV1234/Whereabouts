import 'package:flutter/material.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';

class GroupStatusChip extends StatelessWidget {
  final bool isOwner;
  final String status;
  const GroupStatusChip({super.key, required this.status, 
  required this.isOwner});

  @override
  Widget build(BuildContext context) {
    return isOwner ? Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Image(width: 20, image: const AssetImage(
        'assets/crown_icon.png'),),
    ) : Container(
        color: const Color.fromARGB(255, 221, 221, 221),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: CustomText(
            status, fontSize: 15, 
        ),
    );
  }
}