import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:digipay_master1/models/uid.dart';
import 'package:toast/toast.dart';


class ManageAccounts extends StatelessWidget {

final _formKey = GlobalKey<FormState>();
    int balance=0;
    String h;
    String fb;

Firestore _firestore = Firestore.instance;

 bool validate() {
    final form = _formKey.currentState; //all the text fields will be set to values
    form.save(); // to save the form
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void _addBalance() async {
    if (validate()) {
      try {
        global.wallet = global.wallet + balance;
        //final uid = await Provider.of(context).auth.getCurrentUID();
        await DatabaseService(uid: current_user_uid).updateUserWallet(global.wallet);
        await _firestore.collection('users').document(current_user_uid).collection('transaction history').add({
          'amount': balance,
          'time': FieldValue.serverTimestamp(),
          'closing_balance': global.wallet,
          'operation': 'credit',
          'source': 'accounts',
        });
        fb = global.wallet.toString();
      }
      catch (e) {
        print(e);
      }
    }
  }
static void showToast(String msg,context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersAccountsStreamSnapshots(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading...");
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildAccountCard(context, snapshot.data.documents[index]));
        }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersAccountsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection('Account').snapshots();
  }

  Widget buildAccountCard(BuildContext context, DocumentSnapshot account) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text("Account IFSC: "+account['account_ifsc'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text("Account No: "+account['account_no'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),
              /*Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(card['card_no'], style: new TextStyle(fontSize: 20.0),),
                  Spacer(),
                ]),
              ),*/
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  new RaisedButton(
                                  child: new Text("Add Money to Wallet",
                                  style:TextStyle(
                                    fontSize:18,
                                    color:Colors.black54,
                                  )),
                                  onPressed: (){//performSubmit,
                                  showDialog(
                                      context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: new InputDecoration(labelText: "Money to add in the wallet"),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSaved: (val)=>balance=int.parse(val),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("ADD CASH"),
                              onPressed:() {
                                _addBalance();
                                showToast("₹$balance Credited",context,duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });

                                  }//performSubmit,
                  ),
                  Spacer(),
                ]),
              ),

              /*Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(trip['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endDate'].toDate()).toString()}"),
                  Spacer(),
                ]),
              ),*/
              /*Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    //Text("\$${(trip['budget'] == null)? "n/a" : trip['budget'].toStringAsFixed(2)}", style: new TextStyle(fontSize: 35.0),),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )*/
            ],
          ),
        ),
         
    ));
  }
}
