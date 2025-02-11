import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/group/group_pages/group_info_box.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/stream_widget.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';



class GroupInvitePage extends StatefulWidget {
  const GroupInvitePage({super.key});

  @override
  State<GroupInvitePage> createState() => _GroupInvitePageState();
}

class _GroupInvitePageState extends State<GroupInvitePage> {

  Future<void> submit() async {
    await pushTransparentLoadingRoute(
        context,
        future: context.read<Group>().acceptInvite(),
        onComplete: (data) {}
    );
  }

  @override
  Widget build(BuildContext context) {
     Group group = context.watch<Group>();
    return StreamWidget<List<Account>>(
      stream:  group.getMembersPublicAccounts(),
      onData: (data) => Scaffold(
        appBar: AppBar(),
        body: SetupForm(
            headerHeight: 20,
            title: 'Welcome', 
            customDespcription: 
            Column(
              children: [
                SizedBox(height: 5),
                SizedBox(
                  height: 70,
                  child: GroupInfoBox()
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomText('All members of this group will be able to see your location and your profile',
                    fontSize: 16,)
                ),
              ],
            ),
            children: [
              OutlinedButton(
                child: Text('Join group'),
                onPressed: () => submit() 
              )
            ]
          ),
      ),
    );
  }
}