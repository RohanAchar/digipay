import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:digipay_master1/views/mobile recharge/MobileDetailPage.dart';
import 'package:digipay_master1/views/mobile recharge/global_mobile.dart' as Phoneglobal;


class MobileListPage extends StatefulWidget {

  final String phno;
  MobileListPage({this.phno});

  static const String routeName = "/MyItemsPage";
  @override
  _MobileListPageState createState() => _MobileListPageState();
}

class _MobileListPageState extends State<MobileListPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       body: Container(
      child: StreamBuilder(
          stream: getList(context),
          builder: (context,snapshot){
        if(!snapshot.hasData){
           return Center(
             child: Text("Loading..."),
           );
        } else {
          return  ListView.builder(
                itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildTripCard(context, snapshot.data.documents[index]));
                /*itemBuilder: (context,index){
                  return ListTile(
                    title: Text(snapshot.data.documents[index].data['name']),
                    onTap: () => navigateToDetail(snapshot.data.documents[index].data['pid']),
                  );
                });*/
        }
      }),
    )
    );
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot mob) {
    return new Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text(""+mob['name'],
            style:TextStyle(
              fontSize:20,
            )),
        onPressed: () {
          navigateToDetail(mob['pid'],mob['name'],widget.phno);
        },
      ),
    );
  }
 /* Future getlist() async{
    var _firestore = Firestore.instance;
   QuerySnapshot qn = await _firestore.collection('mobile recharge').getDocuments();
   return qn.documents;

  } */
  Stream<QuerySnapshot> getList(BuildContext context) async* {

    yield* Firestore.instance.collection('mobile recharge').snapshots();
  }

navigateToDetail(String pID,String provider_name,String phno)
{
  print(pID);
  Phoneglobal.phno = phno;
  Phoneglobal.providerName = provider_name;
  Navigator.push(context, MaterialPageRoute(builder: (context) => MobileDetailPage(pID: pID)));
}
  
}