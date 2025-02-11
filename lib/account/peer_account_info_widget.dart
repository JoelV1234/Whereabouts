import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/profile_attribute.dart';

class PeerAccountInfoWidget extends StatelessWidget {
  final Account account;
  const PeerAccountInfoWidget({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(account.photourl ?? ''),
              ),
              SizedBox(height: 20),
              ProfileAttribute(
                icon: Icons.face,
                label: 'Name',
                value: account.displayname ?? 'No name'
              ),
              ProfileAttribute(
                icon: Icons.person,
                label: 'Username',
                value: account.username
              ),
              ProfileAttribute(
                icon: Icons.email,
                label: 'Email',
                value: account.email ?? 'No email'
              ),
              if(account.phonenumber != null)
              ProfileAttribute(
                icon: Icons.phone,
                label: 'Phone',
                value: account.phonenumber ?? 'No phone number'
              ),
            ],
          ),
        ),
      ],
    );
  }
}