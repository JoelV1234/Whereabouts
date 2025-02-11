import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account_page.dart';
import 'package:location_sharing_app/account/my_account.dart';
import 'package:location_sharing_app/group/widgets/groups_list.dart';
import 'package:location_sharing_app/home/widgets/profile_pic.dart';
import 'package:location_sharing_app/notifications/notifications_page.dart';
import 'package:location_sharing_app/sos/sos_page.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Tuple2<Widget, String>> pages = [
    Tuple2(GroupsList(), 'Groups'),
    Tuple2(NotificationsPage(), 'Alerts'),
    Tuple2(SosPage(), 'Emergency'),
  ];
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 500), (timer) {
      context.read<MyAccount>().updateLocation();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_currentIndex].item2),
        actions: [
          ProfilePic(onTap: () => pushPage(context, const AccountPage()))
        ]
      ),
          body:  IndexedStack(
            index: _currentIndex,
            children: pages.map((page) => page.item1).toList(),
          ),
          bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), 
            label: 'Alerts'),

            BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'SOS'),
        ],
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index)
        )
      );
  }
}