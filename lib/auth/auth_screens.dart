import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_sharing_app/account_setup/status_banner.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/simple_transparent_loader.dart';
class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> submit(auth.User user) async {
    if(!(user.emailVerified)) {
      await pushSimpleTransparentLoadingRoute(
        context,
        future: user.sendEmailVerification(),
        onComplete: (data) => showStatusBanner(messengerKey,
        height: 11, 
        "We have sent a verification email, please check your inbox, and re-login", false ),
        onError: (error) => showStatusBanner(messengerKey, error, true)
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: messengerKey,
        child: Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: (context) => SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
              actions: [
                AuthStateChangeAction<UserCreated>((context, state) async {
                  await submit(state.credential.user!);
                  Navigator.pushReplacementNamed(context, '/sign-in');
                }),

                AuthStateChangeAction<SignedIn>((context, state) {
                  submit(state.user!);
                }),
              ],
              footerBuilder: (context, action) {
                return Column(
                  children: [
                    SizedBox(height: 300,),
                  ],
                );
              }
            ),
          ),
        ),
    );
  }
}