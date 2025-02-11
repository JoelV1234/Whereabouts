import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/group/group_pages/group_invite_page.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/group_pages/group_page.dart';
import 'package:location_sharing_app/group/group_repository.dart';
import 'package:location_sharing_app/group/group_settings/group_settings.dart';
import 'package:location_sharing_app/location/map_screen.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:location_sharing_app/widgets/nav_init.dart';
import 'package:location_sharing_app/widgets/stream_widget.dart';
import 'package:provider/provider.dart';


class GroupRouter extends StatefulWidget {
  final String groupId;
  final int? initialIndex;
  const GroupRouter({super.key, 
  required this.groupId,  
  this.initialIndex});

  @override
  State<GroupRouter> createState() => _GroupRouterState();
}

class _GroupRouterState extends State<GroupRouter> {
  
  late int currentIndex = 0;
  bool isError = false;
  late Stream<Group> groupStream;

  @override
  initState() {
    super.initState();
    groupStream = GroupRepository().groupStream(widget.groupId).asBroadcastStream();
  }


  void popPage() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamWidget<Group>(
        onError: (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
          return Center(child: CircularProgressIndicator());
        },
        stream: groupStream,
        onData: (group) {
          bool isInvited = group.isMember(context.read<MyAccount>().uid);
          return StreamProvider(
            create: (context) => groupStream, initialData: group,
            updateShouldNotify: (_, __) => true, 
            catchError: (context, error) => group,
            child: !isInvited ? GroupInvitePage() : NavInit(
              key: ValueKey(currentIndex),
              initialPage: GroupTabs(
                initialPage: widget.initialIndex,
                popPage: popPage,
              ),
            )
          );
        }
      ),

    );
  }
}


class GroupTabs extends StatefulWidget {
  final int? initialPage;
  final VoidCallback popPage;
  const GroupTabs({super.key, 
    required this.popPage, 
    required this.initialPage});

  @override
  State<GroupTabs> createState() => _GroupTabsState();
}

class _GroupTabsState extends State<GroupTabs> {

  late int currentIndex = widget.initialPage ?? 0;


  @override
  Widget build(BuildContext context) {

    Group group = context.watch<Group>();
    List<Widget> pages = [
      GroupPage(),
      MapScreen(uids: group.getMembersUids()),
    ];
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.popPage,
          ),
          actions: [
            if(group.owner == context.read<MyAccount>().uid)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => pushPage(context, GroupSettings()),
            ), 
            SizedBox(width: 13,)
          ],
          title: Text(group.name),
        ),
        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          ],
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
        ),
    );
  }
}
