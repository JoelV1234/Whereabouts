import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_sharing_app/app_gate/app_gate.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/firebase_options.dart';
import 'package:location_sharing_app/styles/button_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: buttonStyle()
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: active,
          foregroundColor: white,
          elevation: 0
        ),
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          filled: true,
          fillColor: Colors.grey.shade300,
          labelStyle: TextStyle(color: const Color.fromARGB(255, 103, 103, 103), fontSize: 15),
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      home: AppGate(),
    );
  }
}