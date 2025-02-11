import 'package:flutter/material.dart';
import 'package:location_sharing_app/account_setup/widgets/setup_form.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionPage extends StatefulWidget {
  final VoidCallback onGranted;
  const LocationPermissionPage({super.key, required this.onGranted});

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {

  bool loading = false;

  Future<void> requestLocation() async {
    setState(() => loading = true);
    await Permission.location.request();
    setState(() => loading = false);
    widget.onGranted();
  }

  @override
  Widget build(BuildContext context) {
    return SetupForm(
      title: 'Permission', 
      description: 'Befor you use this app, please allow location access',
      children: [
        OutlinedButton(
          
          child: loading ? SizedBox(
            height: 16, width: 16,
            child: CircularProgressIndicator(color: white,)
          ) : 
          Text('Allow location access'),  
          onPressed: () {
            if(!loading) {
              requestLocation();
            }
          } 
        )
      ]
    );
  }
}