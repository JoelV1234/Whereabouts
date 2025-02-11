import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';

class SosPage extends StatefulWidget {

  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  final TextEditingController messageController = TextEditingController();
  double horizontalPadding = 16;
  final Map<String, String> predefinedMessagesMap = {
    "Help needed!": "Help needed!",
    "Severe medical condition!": " I am facing a Severe medical condition!",
    "Need assistance!": "EmergencyNeed assistance!",
    "Call for help!": "Call for help!"
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: CustomText(
            'Send a emergency message',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(
              labelText: 'Enter your message',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // Handle custom message input
            },
          ),
        ),
        SizedBox(
          height: 60,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [SizedBox(width: 15)] + predefinedMessagesMap.entries.map((message) {
                return SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 251, 75, 75)),
                      ),
                      onPressed: () {
                        messageController.text = message.value;
                      },
                    child: CustomText(message.key, color: white ),
                                        ),
                  ),
              );
            }).toList(),
            )
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => pushTransparentLoadingRoute(
                context, 
                future: context.read<MyAccount>().sendEmergencyMessage(
                  messageController.text
                ),
              ),
              child: Text('Send Message'),
            ),
          ),
        ),
      ],
    );
  }
}