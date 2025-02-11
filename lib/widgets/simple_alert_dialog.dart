import 'package:flutter/material.dart';

class SimpleAlertDialog extends StatelessWidget {
  final String title;
  final VoidCallback? onOk;
  final Widget content;
  const SimpleAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.onOk
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onOk?.call();
          },
          child: const Text('OK')
        )
      ],
    );
  }
}