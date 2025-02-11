import 'package:flutter/material.dart';
import 'package:location_sharing_app/config/colors.dart';


class ErrorStatusText extends StatelessWidget {
  final String statusMessage;
  final bool isError;
  const ErrorStatusText({super.key, 
    required this.statusMessage,
    required this.isError
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        isError ? Icon(Icons.error, color: errorColor,) :  
        Icon(Icons.check, color: successColor,),
        const SizedBox(height: 2),
        Text(
          statusMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: isError ? successColor : errorColor,
          )
        ),
      ],
    );
  }
}