import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/group/create_group.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/widgets/group_tile.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:provider/provider.dart';


class GroupsList extends StatefulWidget {
  const GroupsList({super.key});

  @override
  State<GroupsList> createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {

  @override
  Widget build(BuildContext context) {
    List<Stream<Group>>? groups = context.watch<MyAccount>().getGroupsList();
    return Scaffold(
      body: Center(
        child: Container(
          child: groups.isEmpty ? CustomText("You are not in any groups yet", 
            fontSize: 15) : ListView(
                children: <Widget>[SizedBox(height: 25)] + groups.map((group) =>
                  Container(
                    decoration: groups.length == 1 ? null : BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: const Color.fromARGB(255, 143, 143, 143), width: 0.5)
                      )
                    ),
                    child: GroupTile(groupStream: group,))
                ).toList(),
              ),
          ),
      ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => const CreateGroup(),)),
            ),
    );
  }
}