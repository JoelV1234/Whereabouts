import 'package:flutter/material.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';

class EditGrpName extends StatefulWidget {
  const EditGrpName({super.key});

  @override
  State<EditGrpName> createState() => _EditGrpNameState();
}

class _EditGrpNameState extends State<EditGrpName> {
  TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SetupForm(
        title: 'Edit group name',
        headerHeight: 20,
        description: 'Create a new group name', 
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) { 
                  return "Please enter a group name";
              } 
              return null;
            },
            controller: groupNameController,
            decoration: const InputDecoration(
              labelText: 'Group name',
            ),
          ),
          SizedBox(height: 10,),
          OutlinedButton(
            child: Text('Save'),
            onPressed: () => pushTransparentLoadingRoute(
              context, 
              future: context.read<Group>().changeGroupName(groupNameController.text),
              onComplete: (data) => Navigator.pop(context)
            ),
          ),
        ],
      ),
    );
  }
}