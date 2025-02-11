import 'package:flutter/material.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning, color: Colors.red, size: 50,),
            CustomText(
              "Something went wrong",
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.bold
            ),
            CustomText(
              error,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}