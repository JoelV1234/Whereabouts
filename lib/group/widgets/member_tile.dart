import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/group/account_sheet/account_sheet.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/group_status_chip.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';



class MemberTile extends StatefulWidget {
  final Account account;
  final bool isOwner;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool invited;
  const MemberTile({super.key, required this.account,
   this.isOwner = false, this.invited = false,
   required this.scaffoldKey});

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {

  Future<void> deleteUser(Group group) async {
    await pushTransparentLoadingRoute(
      context, 
      future: group.removeMember(widget.account.uid), 
    );
  }

  @override
  Widget build(BuildContext context) {
    Group group = context.read<Group>();
    return InkWell(
      onLongPress: () => showAccountSheet(
        context, widget.account, () => deleteUser(group), group),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
          child: Row(
          children: [
    
            CircleAvatar(
              radius: 23,
              backgroundImage: NetworkImage(widget.account.photourl ?? ''),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(widget.account.displayname ?? 'No name', fontSize: 18, fontWeight: FontWeight.w500),
                CustomText(widget.account.username, fontSize: 15, color: const Color.fromARGB(255, 103, 103, 103)),
              ]
            ),
            Expanded(child: Container()),
            if(widget.isOwner || widget.invited)
            GroupStatusChip(
              status: 'invited',
              isOwner: widget.isOwner,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}