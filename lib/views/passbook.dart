import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/dashboard.dart';
import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart'
as global;
import 'package:digipay_master1/models/uid.dart';
import 'package:toast/toast.dart';

final scaffoldKey = new GlobalKey<ScaffoldState>();

class Passbook extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  int balance = 0;
  String h;
  int fb;

  Firestore _firestore = Firestore.instance;

  static void showToast(String msg, context, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: transSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTransCard(context, snapshot.data.documents[index]));
          }),
    );
  }

  Stream<QuerySnapshot> transSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* _firestore
        .collection('users')
        .document(uid)
        .collection('transaction history')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Widget buildTransCard(BuildContext context, DocumentSnapshot trans) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
          width: MediaQuery.of(context).size.width - 30.0,
          height: 130.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: trans['operation'] == "credit_shopping"
                                  ? Text(
                                "Paid for Shopping from Wallet",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              )
                                  : trans['operation'] == "recharge_debit"
                                  ? Text(
                                "Paid for Mobile Recharge from Wallet",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              )
                                  : trans['operation'] == "movie_debit"
                                  ? Text(
                                "Paid for Movie Booking from Wallet",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              )
                                  : Text(
                                "Added to Wallet from " +
                                    trans['source'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              leading: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border:
                                    Border.all(color: Colors.black, width: 1),
                                    image:  trans['operation'] == "credit"
                                        ? DecorationImage(
                                        image: AssetImage('assets/credit.jpg'))
                                        : trans['operation'] == "recharge_debit" || trans['operation'] == "movie_debit"
                                        ? DecorationImage(
                                        image:
                                        AssetImage('assets/debit.jpg'))
                                        : DecorationImage(
                                        image: AssetImage(
                                            'assets/shopping.png'))),
                                //image: DecorationImage(image: AssetImage('assets/shopping.png'))),
                              ),
                              subtitle: Text(
                                "Operation: " + trans['operation'],
                                style:
                                TextStyle(color: Colors.grey, fontSize: 13.0),
                              ),
                              trailing: Container(
                                width: 80.0,
                                height: 25.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.grey[300]),
                                child: Center(
                                  child: Text(
                                    "Rs. ${trans['amount']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "${trans['time'].toDate().toString().split(' ')[0]}",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Closing Balance: Rs. ${trans['closing_balance']}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${trans['time'].toDate().toString().split('.')[0].toString().split(' ')[1].toString().split(':')[0]}:${trans['time'].toDate().toString().split('.')[0].toString().split(' ')[1].toString().split(':')[1]}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 5.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}

