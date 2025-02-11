import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/edit_attributes/edit_name.dart';
import 'package:location_sharing_app/account/edit_attributes/edit_phone_number.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/account/profile_attribute.dart';
import 'package:location_sharing_app/styles/button_style.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyAccount account = context.watch<MyAccount>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(account.photourl ?? ''),
              ),
              SizedBox(height: 20),
              CustomText(account.displayname ?? 'No name', 
              fontSize: 20, fontWeight: FontWeight.bold),
              CustomText(account.username, fontSize: 16, 
              color: const Color.fromARGB(255, 104, 104, 104)),
              SizedBox(height: 10),
                ProfileAttribute(
                icon: Icons.person, 
                label: 'Name', 
                value: account.displayname ?? '',
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => pushPage(
                    context, EditNameScreen()
                  ),
                )
              ),
              ProfileAttribute(
                icon: Icons.email, 
                label: 'Email', 
                value: account.email ?? '',
              ),
              ProfileAttribute(
                icon: Icons.phone, 
                label: 'Phone', 
                value: account.phonenumber ?? 'Add a phone number',
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => pushPage(
                    context, EditPhoneNumberScreen()
                  ),
                )
              ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
              style: buttonStyle(backgroundColor: const Color.fromARGB(255, 255, 71, 71)),
                onPressed: () => FirebaseAuth.instance.signOut(),
                  child: Text('Logout'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}