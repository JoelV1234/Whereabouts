import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({super.key});

  @override
  State<EditPhoneNumberScreen> createState() => _EditPhoneNumberScreenState();
}

class _EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  late TextEditingController phoneController;

  @override
  void initState() {
    phoneController = TextEditingController(
      text: context.read<MyAccount>().phonenumber
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SetupForm(
        headerHeight: 20,
        title: 'Edit phone number',
        customDespcription: Column(
          children: [
            SizedBox(height: 10),
            IntlPhoneField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number (Optional)',
              ),
              initialCountryCode: 'CA',
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: Text('Save'),
                onPressed: () => pushTransparentLoadingRoute(
                  context, 
                  future: context.read<MyAccount>().updatePhoneNumber(
                    phoneController.text),
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