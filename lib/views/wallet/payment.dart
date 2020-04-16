import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/views/movie/global_movie.dart' as Movieglobal;
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
import 'package:digipay_master1/views/mobile recharge/global_mobile.dart' as Phoneglobal;
import 'package:digipay_master1/views/wallet/cards/manage_cards.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/models/uid.dart';
import 'package:digipay_master1/views/movie/display_ticket.dart';
import 'package:digipay_master1/views/wallet/account/manageaccounts/manage_account.dart';
import 'package:toast/toast.dart';
import 'package:digipay_master1/views/dashboard.dart';




void main() => runApp(PayPage());

class PayPage extends StatelessWidget {

  final String page;
  PayPage({this.page});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListTileDemo(title: '$page'),
    );
  }
}

class ListTileDemo extends StatelessWidget {

  Firestore _firestore = Firestore.instance;

  ListTileDemo({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment"),

      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: FlatButton(
              child: ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text(
                'Wallet',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: FlatButton(
                padding: EdgeInsets.only(left: 50.0),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
            onPressed: () async {
    if(title== 'movie') {
    if(global.wallet< Movieglobal.amt){
    global.rem= Movieglobal.amt-global.wallet;
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'movie_wallet',)));
    }
    else{
    global.wallet= global.wallet - Movieglobal.amt;
    await DatabaseService(uid: current_user_uid).updateUserWallet(global.wallet);
    await _firestore
        .collection('users')
        .document(current_user_uid)
        .collection('transaction history')
        .add({
    'amount': Movieglobal.amt,
    'time': FieldValue.serverTimestamp(),
    'closing_balance': global.wallet,
    'operation': 'movie_debit',
    'source': 'wallet',
    });
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DisplayTicket()));
    }
    }
    if(title== 'recharge') {
      if(global.wallet < Phoneglobal.amt){
        global.rem= Phoneglobal.amt-global.wallet;
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'recharge_wallet')));
      }
      else{
        global.wallet= global.wallet - Phoneglobal.amt;
        await DatabaseService(uid: current_user_uid).updateUserWallet(global.wallet);
        await _firestore
            .collection('users')
            .document(current_user_uid)
            .collection('transaction history')
            .add({
          'amount': Phoneglobal.amt,
          'time': FieldValue.serverTimestamp(),
          'closing_balance': global.wallet,
          'operation': 'recharge_debit',
          'source': 'wallet',
        });
        ManageCards.showToast("Mobile Recharged", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Dashboard()));

      }
    }

    },
    ),
          ),
          Card(
            child: FlatButton(
              child: ListTile(
                leading: Icon(Icons.credit_card),
                title: Text(
                  'Credit Card',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: FlatButton(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ),
              onPressed: () {
                if(title == 'movie'){
                global.rem=Movieglobal.amt;
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'movie',)));
                }
                if(title == 'recharge'){
                  global.rem=Phoneglobal.amt;
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'recharge',)));
                }
              },
            ),
          ),
          Card(
            child: FlatButton(
              child: ListTile(
              leading: Icon(Icons.account_balance),
              title: Text(
                'Savings Account',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: FlatButton(
                padding: EdgeInsets.only(left: 50.0),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
            onPressed: () {
              if(title == 'movie'){
                global.rem=Movieglobal.amt;
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageAccounts(page: 'movie',)));
              }
              if(title == 'recharge'){
                global.rem=Phoneglobal.amt;
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageAccounts(page: 'recharge',)));
              }

            },
    ),
          ),
          FlatButton(
            child: Text(
              "Apply Promocode",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
            onPressed: () {

              showDialog(

                  context: context,
                  builder: (BuildContext context) {
                    return PromoCode(page: title);
                  });
              //Navigator.push(
              //  context,
              //MaterialPageRoute(
              //    builder: (context) => PromoCode()));
            },
          ),
        ],
      ),
    );
  }
}

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
      child:
      StreamBuilder(
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
        '9l02E3h1cAyjJcllQMGF').collection(col).snapshots();

  }

  Widget buildTransCard(BuildContext context, DocumentSnapshot promo) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(18.0),
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
                                promo['promo_des'],
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
                                        Navigator.pop(context);
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

