import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatelessWidget {
  final VoidCallback onTap;
  const ProfilePic({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {

    Account? account = Provider.of<MyAccount>(context);
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(account.photourl ?? ''),
          ),
        ),
        SizedBox(width: 10)
      ],
    );
  }
}