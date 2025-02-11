import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/sos/sos.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';


class EmergencyUserTile extends StatelessWidget {
  final Account account;
  final Sos sos;
  const EmergencyUserTile({super.key, required this.account, required this.sos});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color.fromARGB(24, 253, 36, 36),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage( account.photourl ??
              'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             CustomText(account.displayname ?? sos.name
                , fontSize: 18, fontWeight: FontWeight.w500),
               CustomText(sos.contact ?? 'No contact given', fontSize: 16),
            ],
          ),
          Expanded(child: Container()),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}