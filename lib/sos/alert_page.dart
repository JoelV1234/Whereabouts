import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/sos/alert_card.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';
import 'package:provider/provider.dart';


class AlertPage extends StatefulWidget {
  
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {

  @override
  Widget build(BuildContext context) {
    MyAccount myAccount = context.watch<MyAccount>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 36, 36),
        title: const CustomText('Alerts', color: white,),
        actions: [
          IconButton(
            icon: const Icon(Icons.done, weight: 1000,
            color: white,),
            onPressed: () => pushTransparentLoadingRoute(
              context, 
              future: myAccount.seenAlerts(),)
          ),
          SizedBox(width: 10,)
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 253, 36, 36),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: myAccount.alerts.map(
              (sos) => AlertCard(sos: sos)).toList(),
          ),
        ),
    );
  }
}