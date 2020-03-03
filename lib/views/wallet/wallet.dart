import 'package:digipay_master1/views/wallet/account/addaccounts/addaccount.dart';
import 'package:digipay_master1/views/wallet/account/manageaccounts/manage_account.dart';
import 'package:digipay_master1/views/wallet/cards/addcards/cards.dart';
import 'package:digipay_master1/views/wallet/cards/manage_cards.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;
class Dashboard1 extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard1> {

  final _formKey = GlobalKey<FormState>();
    int balance=0;
    String h;
    int fb1=global.wallet;
    final myController = TextEditingController();
    void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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

  void _addBalance(){
    if(validate()){
      global.wallet=global.wallet+balance;
      fb1=global.wallet;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard1()));
      
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Icon(
          Icons.arrow_back,
              color: Colors.white,
        ),
        ),
        title: Text("WALLET"),
      ),
      backgroundColor: Color.fromRGBO(255,255,255, 1.0),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Container(
        height:40,
        width:double.maxFinite,
         margin:EdgeInsets.only(left:1.0,right:1.0),
        child:Card(
          elevation:0.01,
          color:Colors.white,
          
          
        ),
        ), 
        Container(
        height:160,
        width:double.maxFinite,
        margin:EdgeInsets.only(top:0.0),
        child:Card(
          elevation:0.01,
          color:Colors.blue,
          
          child:Align(
                          alignment: Alignment.center,
                          child: Text(
                            'YOUR WALLET BALANCE IS $fb1',
                            style:TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            textAlign: TextAlign.center,                          
                          ),

                          
                        ),

          
        ),
          ),

          
        Text(" "),


          Container(
        child: RaisedButton(color:Colors.white,
                              child: Text("ADD CARD",style:  TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),),
                              onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCard()));
                                //Navigator.of(context).pushNamed("HomePage");
                              },),
        ), 
        Text(""),
        Container(
        child: RaisedButton(color:Colors.white,
                              child: Text("MANAGE CARDS",style:  TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),),
                              onPressed:(){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ManageCards()));
                                //ManageCards();
                                //Navigator.of(context).pushNamed("HomePage");
                              },),
        ),
        Text(""),
        Container(
        child: RaisedButton(color:Colors.white,
                              child: Text("ADD ACCOUNT",style:  TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),),
                              onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddAccount()));
                                //Navigator.of(context).pushNamed("Home");
                              },),
        ),
        Text("   "),
        Container(
        child: RaisedButton(color:Colors.white,
                              child: Text("MANAGE ACCOUNTS",style:  TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),),
                              onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAccounts()));
                                //Navigator.of(context).pushNamed("HomePage");
                              },),
        ),
        /*Container(
        child: RaisedButton(
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
                              decoration: new InputDecoration(labelText: "Money to add in the wallet"),
                              onSaved: (val)=>balance=int.parse(val),
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("ADD CASH"),
                              onPressed:(
                                
                                 _addBalance),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Text("ADD CASH TO WALLET",style:  TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),),
                              
                              
                              ),
        )*/

        
        
        ],
      ),
    );  
  }
  

   
}