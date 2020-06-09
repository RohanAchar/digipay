import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/dashboard.dart';
import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:digipay_master1/views/movie/global_movie.dart' as Movieglobal;
import 'package:digipay_master1/views/mobile recharge/global_mobile.dart' as Phoneglobal;

import 'package:digipay_master1/models/uid.dart';
import 'package:toast/toast.dart';
import 'package:digipay_master1/views/movie/display_ticket.dart';
import 'package:digipay_master1/views/shopping/shop_global.dart';
import 'package:digipay_master1/views/wallet/payment.dart';




final scaffoldKey = new GlobalKey<ScaffoldState>();


class ShopCart extends StatelessWidget {

  final String page;
  ShopCart({this.page});

  final _formKey = GlobalKey<FormState>();
  int balance = 0;
  String h;
  int fb;
  int quantity;

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

  void Editquantity (DocumentSnapshot cart) async {
    if (validate()) {
      try {
        //Shoptotal+= cart['item_price']*quantity;
        await _firestore.collection('users').document(current_user_uid).collection('cart').document(cart.documentID).updateData({
          'item_quantity': quantity,
          'total': cart['item_price']*quantity,
        });
      }
      catch (e) {
        print(e);
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar:  AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text("Shopping Cart"),
        ),
        body: Container(
          color: Colors.white70,
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
        ),

        persistentFooterButtons: <Widget>[
          FloatingActionButton(
              child: Text('Done'),
              onPressed:() {
                Shopamt=0;
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ProceedToPay(page: "shopping");
                    });

              }
          ),

        ]
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider
        .of(context)
        .auth
        .getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection(
        'cart').snapshots();
  }


  Widget buildTripCard(BuildContext context, DocumentSnapshot cart) {
   // Shoptotal+=cart['total'];
    return new Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text("Item name : " + cart['item_name'],
                      style: new TextStyle(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text("Item quantity:  ${cart['item_quantity']}",
                      style: new TextStyle(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text("Item price: ${cart['item_price']}",
                      style: new TextStyle(fontSize: 20.0),),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    new RaisedButton(
                        child: new Text("Edit Quantity",
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
                                                labelText: "Enter the quantity"),
                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction
                                                .done,
                                            onSaved: (val) =>
                                            quantity = int.parse(val),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            child: Text("Update"),
                                            onPressed: () {
                                             // Shoptotal=Shoptotal-cart['total'];
                                              Editquantity(cart);
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
              ],
            ),
          ),

        ));
  }
}

class ProceedToPay extends StatelessWidget {

  final String page;
  ProceedToPay({this.page});


  final _formKey = GlobalKey<FormState>();


  Firestore _firestore = Firestore.instance;

  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Container(
            //margin:  EdgeInsets.all(20.0),
            //width: 600.0,
            height: 250.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                ),
                AppBar(
                  backgroundColor: Colors.blue,
                  centerTitle: true,
                  title: Text("Subtotal"),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: build123(context),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  Widget build123(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: transSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading...");
              }
            else {
              int count=0;
              Shopamt=0;
              final listElements = snapshot.data.documents;
              for (var items in listElements) {
                if(items.data['item_quantity'] > 0 ) {
                  count++;
                }
                Shopamt = Shopamt+ items.data['total'];

              }
              return new Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'SubTotal($count items) = ₹ $Shopamt',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20.0,
                        height: 40.0,

                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: FloatingActionButton.extended(
                          icon: Icon(Icons.payment),
                          label: Text('Proceed to Pay'),
                          onPressed: () {
                            Shoptotal = Shopamt;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PayPage(page: 'shopping',)));

                          },
                        ),
                      ),
                    ],
                  ));
            }
          }),
    );
  }

  Stream<QuerySnapshot> transSnapshots(BuildContext context) async* {

    final uid = await Provider
        .of(context)
        .auth
        .getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection(
        'cart').snapshots();

  }


}