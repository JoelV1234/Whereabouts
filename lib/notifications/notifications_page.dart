import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/sos/alert_card.dart';
import 'package:location_sharing_app/sos/sos.dart';
import 'package:location_sharing_app/widgets/stream_widget.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: StreamWidget<List<Sos>>(
            stream: context.read<MyAccount>().getNotification(),
            onData: (data) => ListView(
              children: data.map((sos) => AlertCard(sos: sos)).toList(),
            ),
          ),
        )
      ),
    );
  }
}