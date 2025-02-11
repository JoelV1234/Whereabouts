import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/search_members/add_members.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/widgets/member_tile.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:location_sharing_app/widgets/stream_widget.dart';
import 'package:provider/provider.dart';



class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Stream<List<Account>>  members;


  void updateMembers() {
    setState(() {
      Group group = context.read<Group>();
      members = group.getMembersStream();
    });
  }

  @override
  initState() {
    super.initState();
    updateMembers();
  }

  @override
  void didChangeDependencies() {
    updateMembers();
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    Group group = Provider.of<Group>(context); 
    MyAccount myAccount = context.watch<MyAccount>();
    return StreamWidget(
      stream: members,
      onData: (members) => Scaffold(
        key: scaffoldKey,
        body: ListView(
          children: members.map((member) => MemberTile(
            scaffoldKey: scaffoldKey,
            account: member,
            invited: !group.isMember(member.uid),
            isOwner: group.owner == member.uid
          )
        ).toList()
      ),
      floatingActionButton: myAccount.uid == group.owner ? 
        FloatingActionButton(
        onPressed: () => pushPage(context, AddMembers(group: group)),
        child: const Icon(Icons.add),
      ) : null,
        ),
    );
  }
}