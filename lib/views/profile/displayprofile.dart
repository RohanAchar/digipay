import 'package:flutter/material.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/services/auth_service.dart';
import 'package:digipay_master1/models/uid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = new GlobalKey<FormState>();


class ProfileView extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context)  {

    Firestore _firestore = Firestore.instance;

    //final user =Provider.of(context).auth.getCurrentUser();

    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('users')
            .document('$current_user_uid')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print("No data found");
            return CircularProgressIndicator();

          } else {
            return displayUserInformation(context, snapshot);


          }
        });
  }




  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

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
        title: Text("Profile Page"),
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



          Text(""),
          Container(
            child: Column(
       
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'NAME : ${user['user_name']}',
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),

              ],
            ),
          ),

          Text(""),
          Text(""),


          Container(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'EMAIL : ${user['user_email']}',
                  style:  TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),

              ],
            ),
          ),
          Text(""),
          Text(""),
          Container(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                    'PHONE No. : ${user['user_phone']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,

                    )
                ),

              ],
            ),
          ),
          Text(""),
          Text(""),

          Container(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    'AADHAR No. : ${user['user_aadhar']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,

                    )
                ),

              ],
            ),

          ),
          Text("   "),
          Text("  "),
          Container(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    'ADDRESS : ${user['user_address']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,

                    )
                ),

              ],
            ),
          ),
          Text(" "),
          Text(" "),
          Text(" "),
          Text(" "),
          Text(" "),


          showEditbtn(context, snapshot),


        ],
      ),
    );
  }
  Widget showEditbtn(context, snapshot) {

    final user = snapshot.data;
    return RaisedButton(
      child: Text("Edit"),
      onPressed: () {
        //scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Editing Data')));
      _showEditProfile(
            user['user_name'], user['user_phone'], user['user_email'],
            user['user_aadhar'], user['user_address'],user['user_wallet'], context);


      },
    );
  }

  bool validate() {
    final form = formKey.currentState; //all the text fields will be set to values
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void _showEditProfile(String n, String p, String e, String aadhar, String add,String wallet, context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text("Edit Profile")),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 2.0,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: n,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.pink, width: 2.0),
                        ),
                        hintText: "Enter name",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    onChanged: (val) {
                      n = val;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 2.0,
                    ),
                  ),
                  child: TextFormField(initialValue: add,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.pink, width: 2.0),
                        ),
                        hintText: "Enter address",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    onChanged: (val) {
                      add = val;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 2.0,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: p,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.pink, width: 2.0),
                        ),
                        hintText: "Enter Phone no.",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    onChanged: (val) {
                      p = val;
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 40),
                  color: Colors.blue,
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,),
                  ),
                  onPressed: () async {
                    if (validate()) {
                      try {
                        final uid = await Provider
                            .of(context)
                            .auth
                            .getCurrentUID();
                        await DatabaseService(uid: uid).updateUserData(
                            n, e, p, aadhar, add,wallet);
                        Navigator.pop(context);
                      }
                      catch (e) {
                        print(e);
                        scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text('Error Updating data')));
                      }
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

}