import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/account/peer_account_info_widget.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/location/user_lacation_page.dart';
import 'package:location_sharing_app/styles/button_style.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:provider/provider.dart';


class AccountSheet extends StatefulWidget {
  final Account account;
  final Group group;
  final void Function() onDelete;
  const AccountSheet({super.key, required this.account, 
    required this.group, required this.onDelete});

  @override
  State<AccountSheet> createState() => _AccountSheetState();
}

class _AccountSheetState extends State<AccountSheet> {

  @override
  Widget build(BuildContext context) {
    MyAccount myAccount = context.read<MyAccount>();
    bool isOwner = widget.group.owner == myAccount.uid;
    return Wrap(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  PeerAccountInfoWidget(account: widget.account),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => pushPage(context, 
                        UserLocationPage(account: widget.account)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.place, size: 20, color: white,),
                          const SizedBox(width: 5,),
                          Text(isOwner ? 'Current location' : 'Leave group'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  widget.group.owner != widget.account.uid ? 
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: buttonStyle(backgroundColor: warnningRed),
                      onPressed: () {
                        Navigator.pop(context);
                         widget.onDelete();},
                      child: Text(isOwner ? 'Remove this user' : 'Leave group'),
                    ),
                  ) : const SizedBox(),
                  SizedBox(height: 50,),
                ],
              ),
            )
        ),
      ],
    );
  }
}

Future<void> showAccountSheet(BuildContext context, 
   Account account,
  void Function() onDelete, Group group) {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0),
        bottomLeft: Radius.circular(0),
      )
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) =>  AccountSheet(
      group: group,
      account: account,
      onDelete: onDelete),
  );
}