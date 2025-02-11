import 'package:flutter/material.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/group/group_settings/edit_grp_name.dart';
import 'package:location_sharing_app/styles/button_style.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({super.key});

  @override
  Widget build(BuildContext context) {
    Group group = context.watch<Group>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit group'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title:  CustomText(group.name),
              subtitle: CustomText('Group name', fontWeight: FontWeight.bold),
              trailing: IconButton(
                onPressed: () => pushPage(context, const EditGrpName()),
                icon: Icon(Icons.edit)
              )
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: buttonStyle(backgroundColor: const Color.fromARGB(255, 255, 71, 71)),
                  onPressed: () {
                    if(context.read<Group>().members.length == 1) {
                      pushTransparentLoadingRoute(
                        context, future: group.deleteGroup(),
                        onComplete: (data) => Navigator.pop(context)
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Cannot delete group'),
                          content: const Text('You cannot delete a group that still has members. pleas remove all the mebers before deleting'),
                          actions: [
                            TextButton(
                              child: const Text('Okay'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Delete group'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}