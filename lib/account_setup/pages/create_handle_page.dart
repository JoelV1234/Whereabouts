import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_sharing_app/account_setup/account_setup_service.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/account_setup/status_banner.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/simple_transparent_loader.dart';


class CreateHandlePage extends StatefulWidget {
  const CreateHandlePage({super.key});

  @override
  State<CreateHandlePage> createState() => _CreateHandlePageState();
}

class _CreateHandlePageState extends State<CreateHandlePage> {
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final userNameController = TextEditingController();
  AccountSetupService service = AccountSetupService();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> submit({
    String? phoneNumber,
    required BuildContext context
  }) async {
    if (formKey.currentState!.validate()) {
      await pushSimpleTransparentLoadingRoute(
        context,
        future: service.createUser(userNameController.text),
        onError: (error) {
          String errorMessage = error.contains('Username already esists') ? 
          'Username already exists' : error.toString();
          showStatusBanner(messengerKey, errorMessage, true);
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SetupForm(
      messengerKey: messengerKey,
      title: "Create a username", 
      description: 
        "This will help your friends uniquely identify you on the app",
      children: [
        Form(
          key : formKey,
          child: TextFormField(
            controller: userNameController,
            validator: (value) {
              if (value == null && value!.isEmpty) { 
                  return "Please enter a valid email";
              } 
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
        ),
        SizedBox(height: 10,),
        OutlinedButton(
          child: Text('Finish setup'),
          onPressed: () => submit(context: context),
        ),
      ],
    );
  }
}