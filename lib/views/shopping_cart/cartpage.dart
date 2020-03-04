import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/dashboard.dart';
import 'package:digipay_master1/views/wallet/cards/manage_cards.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'cartmodel.dart';
import 'package:digipay_master1/views/wallet/account/addaccounts/globals.dart' as global;

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
   
   /*void performSave(String money) async {
    //getData();
    //if (validate()) {
      try{
        final uid = await Provider.of(context).auth.getCurrentUID();
        await DatabaseService(uid: uid).getProfileData(uid);


      }
      catch(e)
    {
      print(e);
      scaffoldKey5.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard1()));

    }
  }*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Cart"),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  "Clear",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => ScopedModel.of<CartModel>(context).clearCart())
          ],
        ),
        body: ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                    .cart
                    .length ==
                0
            ? Center(
                child: Text("No items in Cart"),
              )
            : Container(
                padding: EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: ScopedModel.of<CartModel>(context,
                              rebuildOnChange: true)
                          .total,
                      itemBuilder: (context, index) {
                        return ScopedModelDescendant<CartModel>(
                          builder: (context, child, model) {
                            return ListTile(
                              title: Text(model.cart[index].title),
                              subtitle: Text(model.cart[index].qty.toString() +
                                  " x " +
                                  model.cart[index].price.toString() +
                                  " = " +
                                  (model.cart[index].qty *
                                          model.cart[index].price)
                                      .toString()),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        model.updateProduct(model.cart[index],
                                            model.cart[index].qty + 1);
                                        // model.removeProduct(model.cart[index]);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        model.updateProduct(model.cart[index],
                                            model.cart[index].qty - 1);
                                        // model.removeProduct(model.cart[index]);
                                      },
                                    ),
                                  ]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Total: \₹ " +
                            ScopedModel.of<CartModel>(context,
                                    rebuildOnChange: true)
                                .totalCartValue
                                .toString() +
                            "",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.yellow[900],
                        textColor: Colors.white,
                        elevation: 0,
                        child: Text("BUY NOW"),
                        onPressed: () {
                          if(global.wallet< ScopedModel.of<CartModel>(context,
                                    rebuildOnChange: true)
                                .totalCartValue){
                                  //global.wallet=0;
                                  global.rem= ScopedModel.of<CartModel>(context,
                                    rebuildOnChange: true).totalCartValue - global.wallet;
                                  global.wallet=0;
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ManageCards()));
                                }
                          else{
                            //(val)=>bal=int.parse(val),
                            global.wallet= global.wallet - ScopedModel.of<CartModel>(context,
                                    rebuildOnChange: true).totalCartValue;
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Dashboard()));
                          }

                          
                        },
                      ))
                ])));
  }
}
