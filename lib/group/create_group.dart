import 'package:flutter/material.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/group/group_pages/gorup_router.dart';
import 'package:location_sharing_app/group/group_repository.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';


class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  List<String> selected = [];
  TextEditingController groupNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await pushTransparentLoadingRoute<Map<String, dynamic>>(
        context,
        future: GroupRepository().addGroup(groupNameController.text, selected),
        onComplete: (data) => WidgetsBinding.instance.addPostFrameCallback((_) =>
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => GroupRouter(groupId: data['groupID']),
        ))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Form(
          key: formKey,
          child: SetupForm(
            headerHeight: 20,
            title: 'Create a group', 
            description: 'Enter a name for your group',
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
                child: Text('Create group'),
                onPressed: () => submit(),
              ), 
            ]
          ),
        ),
    );
  }
}