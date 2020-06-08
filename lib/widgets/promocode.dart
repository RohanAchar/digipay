import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:digipay_master1/models/uid.dart';
import 'package:toast/toast.dart';

final scaffoldKey = new GlobalKey<ScaffoldState>();

class PromoCode extends StatelessWidget {

  final String page;
  PromoCode({this.page});


  final _formKey = GlobalKey<FormState>();


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
    String col;
    if (page == "recharge") {
      col = "recharge_codes";
    }
    if (page == "movie") {
      col = "movie_codes";
    }

      yield* _firestore.collection('promo codes').document(
          'TwJ3r6T8FAPnH1DziPFs').collection(col).snapshots();


  }

  Widget buildTransCard(BuildContext context, DocumentSnapshot promo) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(0.0),
      child: Container(
          width: MediaQuery.of(context).size.width - 30.0,
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
                              title:Text(
                                promo['promo_name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              subtitle: Text(
                                promo['promo_desc'],
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
                                  child: FloatingActionButton.extended(
                                      backgroundColor: Colors.grey,
                                      //icon: Icon(Icons.thumb_up),
                                      label: Text('Apply'),
                                      onPressed: () {
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                                      }),
                                ),
                              ),
                            ),
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

