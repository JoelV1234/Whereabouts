import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/account_repository.dart';
import 'package:location_sharing_app/account/simple_user_info_sheet.dart';
import 'package:location_sharing_app/config/colors.dart';
import 'package:location_sharing_app/location/user_lacation_page.dart';
import 'package:location_sharing_app/sos/emergency_user_tile.dart';
import 'package:location_sharing_app/sos/sos.dart';
import 'package:location_sharing_app/utils/push_page.dart';
import 'package:location_sharing_app/widgets/custom_text.dart';
import 'package:provider/provider.dart';


class AlertMessageSheet extends StatefulWidget {
  final Sos sos;
  const AlertMessageSheet({super.key, required this.sos});

  @override
  State<AlertMessageSheet> createState() => _AlertMessageSheetState();
}

class _AlertMessageSheetState extends State<AlertMessageSheet> {

  late Stream<Account> accountStream;

  @override
  void initState() {
    accountStream = AccountRepository()
                    .peerAccount(widget.sos.uid).asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('MMM dd, HH:mm');
    return StreamProvider<Account?>(
      updateShouldNotify: (context, account) => true,
      create: (context) => accountStream,
      initialData: null,
      child: Consumer<Account?>(
        builder: (BuildContext context, account, Widget? child) =>
          (account == null) ? Center(child: CircularProgressIndicator(
            color: warnningRed
          )) : Container(
            color: white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText('Alert message', 
                  fontSize: 27, fontWeight: FontWeight.bold, 
                  color: errorColor,),
                  CustomText(formatter.format(widget.sos.sent), fontWeight: FontWeight.bold,
                  fontSize: 18, color: errorColor,),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () => showSimpleUserInfoSheet(
                      context: context,
                      account: account
                    ),
                    child: EmergencyUserTile(
                      account: account, sos: widget.sos,
                    )),
                  SizedBox(height: 20,),
                  CustomText(widget.sos.message, fontSize: 17,),
                  SizedBox(height: 30,),  
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.place, color: white, size: 20,),
                          SizedBox(width: 5,),
                          const CustomText('Location', 
                          fontWeight: FontWeight.bold, fontSize: 15,),
                        ],
                      ),
                      onPressed: () => pushPage(context, 
                      UserLocationPage(account: account)),
                    )       
                  ),
                  SizedBox(height: 20,),      
                ],
              ),
            ),
          ),
      ),
    );
  }
}

Future<void> showAlertMessageSheet(context, Sos sos) async {
  return showModalBottomSheet<void>(
    
    context: context,
    builder: (BuildContext context) => AlertMessageSheet(sos: sos)
  );
}
  