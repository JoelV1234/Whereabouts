import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/group_pages/gorup_router.dart';
import 'package:location_sharing_app/group/group_status_chip.dart';
import 'package:location_sharing_app/group/widgets/group_tile_sheet.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/stream_widget.dart';
import 'package:provider/provider.dart';



class GroupTile extends StatelessWidget {
  final Stream<Group> groupStream;  
  const GroupTile({super.key, required this.groupStream});

  @override
  Widget build(BuildContext context) {
    return StreamWidget<Group>(
      stream: groupStream,
      onError: (error) => Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        color: warnningRed,
        height: 50,
      ),
      onLoading: Container(),
      onData: (group) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: InkWell(
          onTap: () => pushPage(context, GroupRouter(groupId: group.groupId)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(group.name, fontSize: 18, fontWeight: FontWeight.w500),
                      CustomText('${group.members.length} member${group.members.length == 1 ? '' : 's'}'
                        , fontSize: 15, color: const Color.fromARGB(255, 103, 103, 103)),
                    ]
                  ),
                  Expanded(child: Container()),
                ] + (group.isMember(context.read<MyAccount>().uid) ? [
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => showGroupTileSheet(context, group)
                  )
                ] : [
                  GroupStatusChip(
                    status: 'Not joined', isOwner: false
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {}
                  )
                ]) 
              ),
          ),
        ),
      );
      }
    );
  }
}