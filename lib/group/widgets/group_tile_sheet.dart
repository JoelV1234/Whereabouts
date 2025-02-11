import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/group_pages/gorup_router.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:location_sharing_app/widgets/success_scnackbar.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';


class GroupTileSheet extends StatefulWidget {
  final Group group;
  const GroupTileSheet({super.key, required this.group});

  @override
  State<GroupTileSheet> createState() => _GroupTileSheetState();
}

class _GroupTileSheetState extends State<GroupTileSheet> {

  void goToGroupPage(int index) {
    Navigator.pop(context);
    pushPage(context, GroupRouter(
      groupId: widget.group.groupId,
      initialIndex: index
    ));
  }

  Future<void> leaveGroup() async {
    await pushTransparentLoadingRoute(
      context,
      future: widget.group.removeMember(
        context.read<MyAccount>().uid
      ),
      onComplete: (data) {
        Navigator.pop(context);
        displaySuccessSnackbar(context, 'Left group');
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Members'),
            onTap: () =>  goToGroupPage(0),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Go to map'),
            onTap: () =>  goToGroupPage(1),
          ),
          if (widget.group.owner != context.read<MyAccount>().uid)
          ListTile(
            leading: const Icon(Icons.delete),
              title: const Text('Leave group'),
              onTap: () => leaveGroup(),
            ),
          ],
        ),
    );
  }
}

Future<void> showGroupTileSheet(
  BuildContext context,
  Group group
  ) async {
  await showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(0),
        bottomLeft: Radius.circular(0),
      )
    ),
    context: context,
    builder: (BuildContext context) {
      return GroupTileSheet(group: group);
    },
  );
}