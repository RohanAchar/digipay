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
import 'package:digipay_master1/views/shopping/shop_global.dart' as Shopglobal;



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

  static void showToast(String msg, context, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

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
    showToast("Processing partial payment since wallet balance = ₹${global.wallet}", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'movie_wallet',)));
    }
    else{
    global.wallet= global.wallet - Movieglobal.amt;
    await DatabaseService(uid: current_user_uid).updateUserWallet(global.wallet);
    await _firestore.collection('users').document(current_user_uid).collection('transaction history').add({
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
        showToast("Processing partial payment since wallet balance = ₹${global.wallet}", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'recharge_wallet')));
      }
      else{
        global.wallet= global.wallet - Phoneglobal.amt;
        await DatabaseService(uid: current_user_uid).updateUserWallet(global.wallet);
        await _firestore.collection('users').document(current_user_uid).collection('transaction history').add({
          'amount': Phoneglobal.amt,
          'time': FieldValue.serverTimestamp(),
          'closing_balance': global.wallet,
          'operation': 'recharge_debit',
          'source': 'wallet',
        });
        showToast("Mobile Recharged", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Dashboard()));

      }
    }
    if(title== 'shopping') {
      if(global.wallet < Shopglobal.Shoptotal){
        global.rem= Shopglobal.Shoptotal -global.wallet;
        showToast("Processing partial payment since wallet balance = ₹${global.wallet}", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'shopping_wallet',)));
      }
      else{
       global.wallet= global.wallet - Shopglobal.Shoptotal;
        await DatabaseService(uid: current_user_uid).updateUserWallet(global.wallet);
        await _firestore.collection('users').document(current_user_uid).collection('transaction history').add({
          'amount': Shopglobal.Shoptotal,
          'time': FieldValue.serverTimestamp(),
          'closing_balance': global.wallet,
          'operation': 'shopping_debit',
          'source': 'wallet',
        });
       showToast("Shopping Done", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                if(title == 'shopping'){
                  global.rem= Shopglobal.Shoptotal;
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards(page: 'shopping',)));
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
                global.rem= Movieglobal.amt;
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageAccounts(page: 'movie',)));
              }
              if(title == 'recharge'){
                global.rem= Phoneglobal.amt;
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageAccounts(page: 'recharge',)));
              }
              if(title == 'shopping'){
                global.rem=  Shopglobal.Shoptotal;
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageAccounts(page: 'shopping',)));
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
        child: Center(
          child: Container(
            //margin:  EdgeInsets.all(20.0),
            //width: 600.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 450.0),
                ),
                AppBar(
                  backgroundColor: Colors.blue,
                  centerTitle: true,
                  title: Text("Promocodes"),
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
    if(page == "shopping")
    {
      col = "shopping_codes";
    }

    yield* _firestore.collection('promo codes').document('OJ6yjUf7DNpx0Ya2OiLk').collection(col).snapshots();

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
                              title: Text(
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
                                        if (page == "recharge" && Phoneglobal.amt > promo['amt']) {
                                          Phoneglobal.amt = Phoneglobal.amt - promo['amt'];
                                          showToast("Promocode Applied - ${promo['promo_name']}", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

                                        }
                                       else if (page == "movie" && Movieglobal.amt > promo['amt']) {
                                          Movieglobal.amt = Movieglobal.amt - promo['amt'];
                                          showToast("Promocode Applied - ${promo['promo_name']}", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

                                        }
                                       else if(page == "shopping" && Shopglobal.Shoptotal > promo['amt'])
                                        {
                                          Shopglobal.Shoptotal = Shopglobal.Shoptotal - promo['amt'];
                                          showToast("Promocode Applied - ${promo['promo_name']}", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                        }

                                        else {
                                          showToast("Promocode Not applied", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                        }

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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Container(color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}

