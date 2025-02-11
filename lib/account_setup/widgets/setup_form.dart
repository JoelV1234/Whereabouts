import 'package:flutter/material.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';


class SetupForm extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget> children;
  final bool centerTitle;
  final double? headerHeight;
  final Widget? customDespcription;
  final GlobalKey<ScaffoldMessengerState>? messengerKey;

  const SetupForm({
    super.key,
    this.customDespcription,
    this.headerHeight,
    required this.title,
    required this.children,
    this.messengerKey,
    this.centerTitle = false,
    this.description
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: messengerKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: headerHeight ?? 100),
                  CustomText(
                    textAlign: centerTitle ? TextAlign.center : TextAlign.left,
                    title,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  customDespcription ?? CustomText(
                    description!,
                    fontSize: 16,
                  ),
                  SizedBox(height: 20,),
                ] + children
              ),
            ),
          ),
        ),
    );
  }
}