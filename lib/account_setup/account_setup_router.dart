import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location_sharing_app/account_setup/pages/create_handle_page.dart';
import 'package:location_sharing_app/account_setup/pages/user_info_page.dart';


class AccountSetupRouter extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> snapshot;
  const AccountSetupRouter({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return snapshot.exists ? const UserInfoPage() : CreateHandlePage();
  }
}