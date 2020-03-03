/*import 'package:digipay_master1/models/account.dart';
import 'account_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AccountList extends StatefulWidget {
  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<List<Account>>(context);
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context,index){
        return AccountTile(account:accounts[index]);
      },
      
    );
  }
}
*/