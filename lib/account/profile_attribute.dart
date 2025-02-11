import 'package:flutter/material.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';

class ProfileAttribute extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;
  const ProfileAttribute({super.key, 
    required this.icon, 
    required this.label, 
    required this.value,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: const Color.fromARGB(255, 143, 143, 143), width: 0.5)
        )
      ),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 13),
      child: Row(
        children: [
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(label, fontSize: 12),
              SizedBox(height: 5),
              Row(children: [
                Icon(icon),
                SizedBox(width: 10),
                CustomText(value, fontSize: 16)
              ],)
            ],
          ),
          Expanded(child: Container()),
          trailing ?? Container()
        ],
      ),
    );
  }
}