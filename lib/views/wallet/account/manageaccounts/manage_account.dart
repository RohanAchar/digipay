import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:digipay_master1/views/movie/global_movie.dart' as Movieglobal;
import 'package:digipay_master1/views/mobile recharge/global_mobile.dart' as Phoneglobal;
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:digipay_master1/models/uid.dart';
import 'package:toast/toast.dart';
import 'package:digipay_master1/views/dashboard.dart';
import 'package:digipay_master1/views/movie/display_ticket.dart';
import 'package:digipay_master1/views/shopping/shop_global.dart' as Shopglobal;



class ManageAccounts extends StatelessWidget {

  final String page;
  ManageAccounts({this.page});


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
    return new Scaffold(
        appBar:  AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Savings Account"),
    ),
    body: Container(
    color: Colors.white70,
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
    )
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  new RaisedButton(
                      child: new Text("PAY ${global.rem}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          )),
                      onPressed: () async {

                        if(page=="movie")
                        {
                          showToast("Paid ₹${Movieglobal.amt} for Movie Tickets", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DisplayTicket()));

                        }
                        if(page=="recharge")
                        {
                          showToast("Paid ₹${Phoneglobal.amt} for Movie Tickets", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Dashboard()));

                        }
                        if(page=="shopping")
                        {
                          DatabaseService(uid: current_user_uid).delete();
                          showToast("Paid ₹${Shopglobal.Shopamt} for Shopping", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Dashboard()));

                        }


                      }

                  ),
                  //////////////////////////////////////
                  //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards()));
                  ///////////////performSubmit,

                  Spacer(),
                ]),
              ),
            ],
          ),
        ),
         
    ));
  }
}
