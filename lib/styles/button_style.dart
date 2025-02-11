import 'package:flutter/material.dart';
import 'package:location_sharing_app/config/colors.dart';

ButtonStyle buttonStyle({
  Color? backgroundColor,
  Color? foregroundColor
}) => ButtonStyle(
  shape: WidgetStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      side: const BorderSide(color: Colors.transparent, width: 0),
      borderRadius: BorderRadius.circular(3.0),
    ),
  ),
  side: WidgetStateProperty.all<BorderSide>(
    const BorderSide(color: Colors.transparent, width: 0)
  ),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
    const EdgeInsets.all(15)
  ),
  backgroundColor: WidgetStateProperty.all<Color>(backgroundColor ?? active),
  foregroundColor: WidgetStateProperty.all<Color>(foregroundColor ?? white),
);