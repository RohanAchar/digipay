
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/shopping/shop_global.dart';
import 'package:digipay_master1/views/shopping/shopPage.dart';
import 'phones.dart';
import 'acc.dart';



class ShopHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Shopping Mall"),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), onPressed: () {},),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {},),
          ],
        ),
      ),


      body: Center(child: SwipeList()),
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

  List items = getDummyList();
  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter discount for the item:"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation:5.0,
                child:Text("Submit"),
                onPressed: (){
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }
  //================
  Future<String> createAlertDialog1(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Restock quantity for the item:"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation:5.0,
                child:Text("Submit"),
                onPressed: (){
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }
  //================
  //================
  Future<String> createAlertDialog2(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Price for the item:"),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation:5.0,
                child:Text("Submit"),
                onPressed: (){
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
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
                  child: new InkWell(
                    onTap: () {
                      if(items[index]=="ALL"){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ShopAll()));
                      }
                      else if(items[index]=="PHONES"){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ShopPhones()));
                      }
                      else{
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ShopAccessories()));
                      }
                    },
                    child: Container(
                      height: 150.0,
                      child: Wrap(
                        spacing: 1.0,
                        runSpacing: 6.0,
                        direction: Axis.vertical,
                        children: <Widget>[
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

                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                    child: Container(
                                      width: 260,

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
                )
            );
          },
        ));
  }

  static List getDummyList() {
    List list = List.generate(3, (i) {
      a=cat[i];
      print(a);
      return cat[i];
    });
    return list;
  }
}