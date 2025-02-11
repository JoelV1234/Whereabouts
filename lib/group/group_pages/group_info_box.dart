import 'package:flutter/material.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:provider/provider.dart';


class GroupInfoBox extends StatelessWidget {
  const GroupInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    Group group = context.watch<Group>();
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(47, 191, 191, 191),
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
          ]
      ),
    );
  }
}