import 'package:flutter/material.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';

void displaySuccessSnackbar(BuildContext context, String message) async{
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: successColor,
        content: CustomText(message),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () => 
          ScaffoldMessenger.of(context).hideCurrentSnackBar()),
        ),
      );
    });
}