import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/simple_user_info_sheet.dart';
import 'package:location_sharing_app/location/map_screen.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';

class UserLocationPage extends StatefulWidget {
  final GeoPoint? initialLocation;
  final Account account;
  const UserLocationPage({
    super.key, required this.account, 
    this.initialLocation
  });

  @override
  State<UserLocationPage> createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(widget.account.displayname ?? 'No name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showSimpleUserInfoSheet(context: context, 
            account: widget.account),
          ),
        ],
      ),
      body: MapScreen(uids: [widget.account.uid]),
    );
  }
}