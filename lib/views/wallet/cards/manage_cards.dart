import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/dashboard.dart';
import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:digipay_master1/models/uid.dart';
import 'package:toast/toast.dart';

final scaffoldKey = new GlobalKey<ScaffoldState>();


class ManageCards extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  int balance = 0;
  String h;
  int fb;

  Firestore _firestore = Firestore.instance;


  bool validate() {
    final form = _formKey
        .currentState; //all the text fields will be set to values
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
        fb = global.wallet;
        await DatabaseService(uid: current_user_uid).updateUserWallet(
            global.wallet);
        await _firestore.collection('users').document(current_user_uid).collection('transaction history').add({
          'amount': balance,
          'time': FieldValue.serverTimestamp(),
          'closing_balance': global.wallet,

        });
        print(global.wallet);
        //Navigator.pushReplacement(context, newRoute)
      }
      catch (e) {
        print(e);
      }
    }
  }

  static void showToast(String msg, context, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUsersTripsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.documents[index]));
          }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider
        .of(context)
        .auth
        .getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection(
        'cards').snapshots();
  }


  Widget buildTripCard(BuildContext context, DocumentSnapshot card) {
    return new Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text("Card Name: " + card['card_name'],
                      style: new TextStyle(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text("Card Expiry: " + card['card_exp'],
                      style: new TextStyle(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text("Card No: " + card['card_no'],
                      style: new TextStyle(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    new RaisedButton(
                        child: new Text("Add Money to Wallet",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            )),
                        onPressed: () {
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

                                            decoration: new InputDecoration(
                                                labelText: "Enter the amount"),
                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction
                                                .done,
                                            onSaved: (val) =>
                                            balance = int.parse(val),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            child: Text("ADD CASH"),
                                            onPressed: () {
                                              _addBalance();
                                              showToast(
                                                  "₹$balance Credited", context,
                                                  duration: Toast.LENGTH_SHORT,
                                                  gravity: Toast.BOTTOM);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }

                          );
                          //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards()));
                        } //performSubmit,
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
                          global.rem = 0;
                          await DatabaseService(uid: current_user_uid)
                              .updateUserWallet(global.wallet);
                          showToast("Money Debited", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => Dashboard()));
                          //showDialog(
                          //context: context,
                          //builder: (BuildContext context) {
                          //return AlertDialog(
                          //content: Form(
                          ///key: _formKey,
                          //child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          //children: <Widget>[
                          //Padding(
                          ///padding: EdgeInsets.all(8.0),
                          //child: TextFormField(
                          //decoration: new InputDecoration(labelText: "Money to add in the wallet"),
                          //keyboardType: TextInputType.number,
                          //textInputAction: TextInputAction.done,
                          //onSaved: (val)=>balance=int.parse(val),
                          //),
                          //),

                          // Padding(
                          // padding: const EdgeInsets.all(8.0),
                          //child: RaisedButton(
                          //child: Text("ADD CASH"),
                          //onPressed:(

                          // _addBalance

                          //),
                          //),
                          //)
                          //],
                          //),
                          //),
                          //);
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

