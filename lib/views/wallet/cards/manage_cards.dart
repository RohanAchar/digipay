import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*class ManageCards extends StatelessWidget {

   Firestore _firestore = Firestore.instance;
   String uid;
   ManageCards(){
   getUId();
   }

   Future<String> getUId() async{
     final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    uid=  (await _firebaseAuth.currentUser()).uid;
    print(uid);
   }

  @override
  Widget build(BuildContext context) {

     return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .document(uid)
            .collection('cards')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
             return Text("error");
            
          } else {
            final listElements = snapshot.data.documents;
            List<CardDetails> conversationList = [];
            for (var user in listElements) {
              final String uid = user.data['user_id'];
              print('$uid');

              final z = CardDetails(
                friendUID: uid,
              );
              conversationList.add(z);
            }
            
            return ListView(
              children: conversationList,
            );
          }
            print(snapshot.data.documents);
            return Text('${snapshot.data.documents}');

          }

    

  
     );
}
}
class CardDetails extends StatelessWidget {
  final String card_cvv;
  final String card_exp;
  final String card_name;
  final String card_no;
  
  Firestore _firestore = Firestore.instance;
  CardDetails({this.card_cvv, this.card_exp,this.card_name,this.card_no});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('');
        } 
      
    );
  }
}
*/
class ManageCards extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersTripsStreamSnapshots(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading...");
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildTripCard(context, snapshot.data.documents[index]));
        }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection('cards').snapshots();
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
                  Text(card['card_name'], style: new TextStyle(fontSize: 30.0),),
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
      ),
    );
  }
}
