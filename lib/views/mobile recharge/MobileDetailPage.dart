import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:digipay_master1/views/mobile recharge/RechargeConfirmation.dart';
import 'package:digipay_master1/views/mobile recharge/global_mobile.dart' as Phoneglobal;


class MobileDetailPage extends StatefulWidget {

  final String pID;
  MobileDetailPage({this.pID});

  @override
  _MobileDetailPageState createState() => _MobileDetailPageState();
}

class _MobileDetailPageState extends State<MobileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
          child: StreamBuilder(
              stream: getPlans(context),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Text("Loading..."),
                  );
                } else {
                  return  ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildPlanCard(context, snapshot.data.documents[index]));


                }
              }),
        )
    );
  }

  Stream<QuerySnapshot> getPlans(BuildContext context) async* {
    yield* Firestore.instance.collection('mobile recharge').document(widget.pID).collection('plans').snapshots();
  }


  Widget buildPlanCard(BuildContext context, DocumentSnapshot plan) {
    double c_width = MediaQuery.of(context).size.width * 0.92;
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
          child: ListView(children: <Widget>[SingleChildScrollView(
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
                              leading: Container(
                                width: 80.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.grey[300]),
                                child: Center(
                                  child: Text(
                                    "₹${plan['plan_amt']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                              trailing: Container(
                                width: 100.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    color: Colors.white),
                                child: Center(
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.lightBlue)),
                                    child: new Text("Select",style: TextStyle(color: Colors.lightBlue,fontSize: 15),),
                                    splashColor: Colors.cyan,
                                    onPressed: (){

                                      navigateToConfirm(widget.pID,plan['plan_amt'],plan['plan_description']);

                                    },


                                  ),
                                ),
                              ),
                            ),
                            Divider(indent: 20, endIndent: 20, thickness: 1),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(16.0),
                                      width: c_width,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            ""+plan['plan_description'],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          ])
      ),
    );

  }

  navigateToConfirm(String pID,int amt,String des)
  {
    Phoneglobal.amt = amt;
    Phoneglobal.plan_description = des;
    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(pID: pID )));

  }

/*Future getPlans() async{
    var _firestore = Firestore.instance;
    QuerySnapshot qn = await _firestore.collection('mobile recharge').document(widget.pID).collection('plans').getDocuments();
    return qn.documents;

  }
*/


}
