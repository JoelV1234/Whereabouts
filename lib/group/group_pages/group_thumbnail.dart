import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';

class GroupThumbnail extends StatelessWidget {
  final List<Account> accounts;
  const GroupThumbnail({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return Center( 
    child: Row( 
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [ 
        for (int i = 0; i < accounts.length; i++) 
          Align( 
            widthFactor: 0.5, 
                // parent circle avatar.  
                // We defined this for better UI 
            child: CircleAvatar( 
              radius: 30, 
              backgroundColor: Colors.white, 
                  // Child circle avatar 
              child: CircleAvatar( 
                radius: 25, 
                backgroundImage: NetworkImage(accounts[i].photourl ?? ''), 
              ), 
            ), 
          ) 
        ], 
      )
    ); 
  }
}