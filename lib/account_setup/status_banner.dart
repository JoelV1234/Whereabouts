  import 'package:flutter/material.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';

Future<void> showStatusBanner(
    GlobalKey<ScaffoldMessengerState> key,
    String message,
    bool isError, {
      double height = 0,
    }
  ) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      key.currentState?.removeCurrentMaterialBanner();
      key.currentState?.showMaterialBanner(
        MaterialBanner (
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: height),
            child: CustomText(message, color: white),
          ),
          backgroundColor: isError ?  warnningRed : successColor,
          actions: [
            TextButton(
              child: const CustomText('Ok', color: white),
              onPressed: () => key.currentState?.removeCurrentMaterialBanner(),
            ),
          ],
        ),
      );
    });
  }
