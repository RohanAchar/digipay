
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

           /* final listElements = snapshot.data.documents;
            List<UserDeets> conversationList = [];
            for (var user in listElements) {
              final String uid = user.data['user_id'];
              print('$uid');

              final z = UserDeets(
                friendUID: uid,
              );
              conversationList.add(z);
            }
            loading = false;
            return ListView(
              children: conversationList,
            );*/
          }
        });
  }


    /*return SingleChildScrollView(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        key: _formKey,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    ); */


  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name : ${user['user_name']}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email : ${user['user_email']}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Phone No. : ${user['user_phone']}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Aadhar No : ${user['user_aadhar']}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Address : ${user['user_address']}", style: TextStyle(fontSize: 20),),
        ),


        showEditbtn(context, snapshot),
      ],
    );
  }

  Widget showEditbtn(context, snapshot) {

    final user = snapshot.data;
      return RaisedButton(
        child: Text("Edit"),
        onPressed: () {
          scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Editing Data')));
   // _showEditProfile(user.name, user.phone, user.email, user.aadhar, user.address);


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

 /*void _showEditProfile(String n, String p,String e, String aadhar, String add) {

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

                  color: Colors.lightGreen,
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,),
                  ),
                  onPressed: () async {
                    if(validate()) {
                      try {
                        final uid = await Provider
                            .of(context)
                            .auth
                            .getCurrentUID();
                        await DatabaseService(uid: uid).updateUserData(
                            n, e, p, aadhar, add);
                        Navigator.pop(context);
                      }
                      catch(e)
                    {
                      print(e);
                      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Error Updating data')));
                    }
                    }
                  },
                ),
              ],
            ),
          );
        }); */
  }


