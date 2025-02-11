import 'package:flutter/material.dart';
import 'package:location_sharing_app/account/account.dart';
import 'package:location_sharing_app/account/account_repository.dart';
import 'package:location_sharing_app/search_members/user_chip.dart';
import 'package:location_sharing_app/search_members/user_tile.dart';
import 'package:location_sharing_app/group/models/group.dart';
import 'package:location_sharing_app/widgets/future_widget.dart';
import 'package:location_sharing_app/widgets/tansparent_loading_page/transparent_loading_route.dart';


class AddMembers extends StatefulWidget {
  final Group group;
  const AddMembers({super.key, required this.group});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  String search = '';
  Set<Account> selected = {};
  Future<List<Account>> accounts = Future.value([]);

  Future<void> submit() async {
   await pushTransparentLoadingRoute(
      context,
      future: widget.group.inviteUsers(selected),   
      onComplete: (data) => WidgetsBinding.instance.addPostFrameCallback((_) => 
        Navigator.pop(context)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add members')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
              TextField(
                onChanged: (value) => setState(() 
                  {accounts = AccountRepository().getPublicAccounts(value);
                }),
                decoration: InputDecoration(
                  labelText: 'Search users by username',
                ),
              ),
            
            selected.isNotEmpty ? SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: selected.map((account) => UserChip(
                  onDelete: () => setState(() => selected.remove(account)),
                  account: account)).toList(),
              ),
            ) : SizedBox(height: 20),
            Expanded(   
              child: FutureWidget<List<Account>>(
                future: accounts,
                onComplete: (data) {
                  return ListView(
                    children: data.map((Account account) {
                      return UserTile(
                      isOwner: widget.group.owner == account.uid,
                      isMember: widget.group.isMember( account.uid),
                      isSelected: selected.contains(account),
                      onSelected: (isSelected) {
                        setState(() {});
                        isSelected ? selected.add(account): 
                                      selected.remove(account);
                      },
                      account: account,);}).toList(),  
                );
                }
              ),
            )
          ],
        ),
      ),
      floatingActionButton: selected.isNotEmpty ? FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () => submit(),
      ) : null,
    );
  }
}