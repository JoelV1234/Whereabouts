import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/peer_account_info_widget.dart';

Future<void> showSimpleUserInfoSheet({
  required BuildContext context,
  required Account account
}) async {
  await showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0),
        bottomLeft: Radius.circular(0),
      )
    ),
    builder: (BuildContext context) => 
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
      child: PeerAccountInfoWidget(account: account),
    )
  );
}