import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account_repository.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/account_setup/account_setup_router.dart';
import 'package:location_sharing_app/auth/auth_screens.dart';
import 'package:location_sharing_app/home/home_screen.dart';
import 'package:location_sharing_app/location/location_permission_page.dart';
import 'package:location_sharing_app/sos/alert_page.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/future_widget.dart';
import 'package:location_sharing_app/widgets/loaded_stream_provider.dart';
import 'package:location_sharing_app/widgets/loading_screen.dart';
import 'package:location_sharing_app/widgets/nav_init.dart';
import 'package:location_sharing_app/widgets/simple_alert_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class AppGate extends StatefulWidget {
  const AppGate({super.key});

  @override
  State<AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<AppGate> {

  Future<PermissionStatus> locationPerm = Permission.location.status;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>(
      catchError: (context, error) {
        showDialog(context: context,
          builder: (context) => SimpleAlertDialog(
            title: 'Error',
            content: CustomText(error.toString()),
            onOk: () => Navigator.pop(context),
          ),
        );
        return null;
      },
      initialData: FirebaseAuth.instance.currentUser,
      create: (context) => FirebaseAuth.instance.authStateChanges(),
      child: Consumer<User?>(
        builder: (context, user, child) {
          if (user?.emailVerified != true) {
            return const AuthScreens();
          }
          return FutureWidget<PermissionStatus>(
            future: locationPerm,
            onComplete: (data) => data.isGranted ?
             StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: AccountRepository.userDoc(user!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.data()?.containsKey('phone') != true) {
                    return AccountSetupRouter(snapshot: snapshot.data!);
                  } else {
                    return  LoadedStreamProvider<MyAccount>(
                        stream: AccountRepository().adminAccount(
                                FirebaseAuth.instance.currentUser!.uid).asBroadcastStream(),
                        onData: (account) => account.alerts.isEmpty ? NavInit(
                            initialPage: const HomeScreen()) : AlertPage()
                    );
                  }
                }
                return const LoadingScreen();
              },
            ) : LocationPermissionPage(
              onGranted: () => setState(() {
                locationPerm = Permission.location.request();
              }),
            ),
          );
        },
      ),
    );
  }
}