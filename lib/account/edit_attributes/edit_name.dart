import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({super.key});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(
      text: context.read<MyAccount>().displayname
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SetupForm(
        headerHeight: 20,
        title: 'Edit display name',
        customDespcription: Column(
          children: [
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) { 
                    return "Please enter a valid name";
                } 
                return null;
              },
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Edit name',
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: Text('Save'),
                onPressed: () => pushTransparentLoadingRoute(
                  context, 
                  future: context.read<MyAccount>().changeDisplayName(
                    nameController.text),
                  onComplete: (data) {
                    Navigator.pop(context);
                  } 
                ),
              ),
            ),
          ],
        ), children: [],
      ),
    );
  }
}

