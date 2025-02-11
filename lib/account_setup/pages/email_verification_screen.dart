import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_sharing_app/account_setup/account_setup_service.dart';
import 'package:location_sharing_app/account_setup/status_banner.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/simple_transparent_loader.dart';


class VerifyEmailScrenn extends StatefulWidget {
  const VerifyEmailScrenn({super.key});

  @override
  State<VerifyEmailScrenn> createState() => _VerifyEmailScrennState();
}

class _VerifyEmailScrennState extends State<VerifyEmailScrenn> {
  final AccountSetupService service = AccountSetupService();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();


  Future<void> submit() async {
      await pushSimpleTransparentLoadingRoute(
        context,
        future: service.verifyEmail(),
        onComplete: (data) => showStatusBanner(messengerKey, 
        "Verification email has been sent", false ),
        onError: (error) => showStatusBanner(messengerKey, error, true)
      );
  }

  @override
  Widget build(BuildContext context) {
    return SetupForm(
      messengerKey: messengerKey,
      title: "Verify your email",
      centerTitle: true,
      customDespcription: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          CustomText("We will need you to relogin after you verify your email. We have sent a verification link to", 
          fontSize: 16.8, textAlign: TextAlign.center),
          CustomText(service.email, fontSize: 16.8, fontWeight: FontWeight.bold),
        ]),
        children: [
          OutlinedButton(
            child: Text('Verify'),
            onPressed: () => submit(),
          ),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              child: Text('Return to login'), 
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          )
      ],
    );
  }
}