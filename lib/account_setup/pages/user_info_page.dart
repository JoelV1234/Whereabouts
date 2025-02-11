import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:location_sharing_app/account_setup/account_setup_service.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/account_setup/status_banner.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/simple_transparent_loader.dart';

class UserInfoPage extends StatefulWidget {

  const UserInfoPage({
    super.key, 
  });

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController displayNameController = TextEditingController(
    text: FirebaseAuth.instance.currentUser?.displayName
  );

  AccountSetupService service = AccountSetupService();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await pushSimpleTransparentLoadingRoute(
        context,
        future: service.updateInfo(
          phoneController.text.isEmpty ? null : phoneController.text, 
          displayNameController.text),
        onError: (error) => showStatusBanner(messengerKey, error, true)
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return SetupForm(
      messengerKey: messengerKey,
      title: 'Tell us about yourself', 
      description: 'Enter your name and phone number (optional)',
      children: [
      Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) { 
                    return "Please enter a valid name";
                } 
                return null;
              },
              controller: displayNameController,
              decoration: InputDecoration(
                labelText: 'Your name',
              ),
            ),
            SizedBox(height: 10,),
            IntlPhoneField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number (Optional)',
              ),
              initialCountryCode: 'CA',
            ),
          ],
        ),
      ),
        SizedBox(height: 10,),
        OutlinedButton(
          child: Text('Finish setup'),
          onPressed: () => submit(),
        ),
      ]
    );
  }
}