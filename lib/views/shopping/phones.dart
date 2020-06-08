import 'package:flutter/material.dart';
import 'package:digipay_master1/views/shopping/shop_global.dart';
import 'package:digipay_master1/views/shopping/shophomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/models/uid.dart';
import 'ShopCart.dart';





class ShopPhones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phones"),
        actions: <Widget>[

          FlatButton(
            child: Text('Change Category'),
            color: Colors.lightBlueAccent[500],
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ShopHomePage()));
            },
          ),

        ],
      ),
      body: Center(child: SwipeList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ShopCart()));
        },
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.deepOrange[900],
      ),
    );
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {
  int j;
  final _formKey = GlobalKey<FormState>();
  int quantity;
  List items = getDummyList();
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();


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
  void _addBalance() async{
    if(validate()){
      TextEditingController customController = TextEditingController();

      Firestore _firestore = Firestore.instance;
      //await DatabaseService(uid: cid).updateItemDiscount(discount,id);
      await _firestore.collection('users').document(current_user_uid).collection('cart').add({
        'item_price': int.parse(phoneP[j]),
        'item_name': phone[j],
        'item_quantity': quantity,
        'total': int.parse(phoneP[j])*quantity,
      });


    }


  }
  //================
  Future<String> createAlertDialog1(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("How Many"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: new InputDecoration(labelText: "Enter quantity of the item"),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onSaved: (val)=>quantity=int.parse(val),
                    ),
                  ),

                  Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Submit"),
                      onPressed:()
{

                          _addBalance();
                          Navigator.pop(context);

        },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
  //================

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Dismissible(

              key: Key(items[index]),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              direction: DismissDirection.endToStart,
              child: Card(

                elevation: 5,
                child: Container(
                  height: 70.0,
                  child: Wrap(
                    spacing: 1.0,
                    runSpacing: 6.0,
                    direction: Axis.vertical,
                    children: <Widget>[
                      //Text("hry")

                      Container(
                        height: 100.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5)),
                          // image: DecorationImage(
                          //  fit: BoxFit.cover,
                          //   image: NetworkImage("https://is2-ssl.mzstatic.com/image/thumb/Video2/v4/e1/69/8b/e1698bc0-c23d-2424-40b7-527864c94a8e/pr_source.lsr/268x0w.png")
                          // )
                        ),
                      ),
                      //================================
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ButtonTheme(
                              child: ButtonBar(
                                children: <Widget>[

                                  RaisedButton(

                                      child: const Text('Add to Cart',
                                          style: TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        j=index;
                                        createAlertDialog1(context).then((onValue){
                                          SnackBar mySnackbar =SnackBar(content:Text("Added To Cart") );
                                          Scaffold.of(context).showSnackBar(mySnackbar);
                                        });
                                      }),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      //==================================
                      Container(
                        height: 85,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 2, 0, 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                items[index],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 4, 0, 2),
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.teal),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                                  /*child: Text(
                                "Quantity Left : 65 KG",
                                //Text("Discount : $onValue")
                                textAlign: TextAlign.center,
                              ),*/
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                child: Container(
                                  width: 260,
                                  child: Text(
                                    "Price :"+phoneP[index],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 48, 48, 54)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  static List getDummyList() {
    List list = List.generate(3, (i) {
      return phone[i];
    });
    return list;
  }
}