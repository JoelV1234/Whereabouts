import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/sos/alert_message_sheet.dart';
import 'package:location_sharing_app/sos/sos.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';


class AlertCard extends StatelessWidget {
  final Sos sos;
  const AlertCard({super.key, required this.sos});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('MMM dd, HH:mm');
    return InkWell(
      onTap: () => showAlertMessageSheet(context, sos),
      child: Container(
          color: warnningRed ,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column (
           mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        sos.name,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      CustomText(
                        formatter.format(sos.sent),
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                sos.message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16.5,
                  color: Colors.white 
                )
              ),       
            ],
          ),
        ),
      ),
    );
  }
}