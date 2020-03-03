import 'package:digipay_master1/views/profile/profile.dart';
import 'package:digipay_master1/views/shopping_cart/cartmodel.dart';
import 'package:digipay_master1/views/shopping_cart/cartpage.dart';
import 'package:digipay_master1/views/shopping_cart/home.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:digipay_master1/services/auth_service.dart';
import 'shop.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:digipay_master1/views/wallet/wallet.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title:
          Stack(
  children: <Widget>[
    // Stroked text as border.
    Text(
      '          DigiPay          ',
      style: TextStyle(
        fontSize: 40,
        fontWeight:FontWeight.bold,
        fontStyle:FontStyle.italic,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..color = Colors.blue[700],
      ),
    ),
    // Solid text as fill.
    Text(
      '          DigiPay          ',
      style: TextStyle(
        fontSize: 40,
        fontStyle:FontStyle.italic,
        fontWeight:FontWeight.bold,
        color: Colors.grey[300],
      ),
    ),
  ],
),
        backgroundColor: Color.fromRGBO(70, 70, 140, 1.0),
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out!");
              } catch (e) {
                print (e);
              }
            },
          )
          
        ],
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
          child:new Text("        Your Digipay wallet is here                            ",
                      style:
                          new TextStyle(fontSize: 25.0, color: Colors.black87)),
          
        ),
        ), 
        Container(
        height:160,
        width:double.maxFinite,
        margin:EdgeInsets.only(top:0.0),
        child:Card(
          elevation:0.01,
          color:Colors.blue[800],
          child:GridView.count(
          crossAxisCount:3,
          mainAxisSpacing:0.2,
          crossAxisSpacing:0.2,
          padding: EdgeInsets.all(1.0),
          children: <Widget>[
            makeDashboardItem("Pay", Icons.payment),
            makeDashboardItem("Profile", Icons.people),
            makeDashboardItem("Wallet", Icons.account_balance),
          ],
        ), 
        ),
          ),
          Container(
        padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 4.0),
        height:60,
        width:double.maxFinite,
        child:Card(
          elevation:0.01,
          color:Colors.white,
          child:new Text("                      Book on DigiPay                              ",
                      style:
                          new TextStyle(fontSize: 21.0, color: Colors.black87)),
          
        ), 
        ), 
        Container(
        height:120,
        width:double.maxFinite,
        child:Card(
          elevation:0.01,
          color:Colors.white,
          child:GridView.count(
          crossAxisCount:3,
          padding: EdgeInsets.all(1.0),
          children: <Widget>[
            makeDashboardItem1("Shopping", Icons.shopping_basket),
            makeDashboardItem1("Bus", Icons.directions_bus),
            makeDashboardItem1("Movies", Icons.movie),
          ],
        ), 
        ),
          ),
           Container(
        height:50,
        width:double.maxFinite,
        child:Card(
          elevation:0.01,
          color:Colors.white,
          child:new Text("                            Pay Bills                              ",
                      style:
                          new TextStyle(fontSize: 21.0, color: Colors.black87)),
          
        ), 
        ),
        Container(
        height:120,
        width:double.maxFinite,
        child:Card(
          elevation:0.01,
          color:Colors.white,
          child:GridView.count(
          crossAxisCount:3,
          padding: EdgeInsets.all(1.0),
          children: <Widget>[
            makeDashboardItem1("Electricity", Icons.lightbulb_outline),
            makeDashboardItem1("Mobile", Icons.phone_android),
            makeDashboardItem1("Cart", Icons.local_grocery_store),
          ],
        ), 
        ),
          ),
        ],
      ),
    );  
  }
  

  Card makeDashboardItem1(String title, IconData icon) {
    return Card(
      color:Colors.white,
        elevation: 0.01,
        margin: new EdgeInsets.all(1.0),
        child: Container(
          child: new InkWell(
            onTap: () {
              if(title=='Shopping')
              Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(model:CartModel())));

              //else if(title=='Bus')
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(model: null)));

              //else if(title=='Movies')
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(model: null)));

              //else if(title=='Electricity')
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(model: null)));

              //else if(title=='Mobile')
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(model: null)));

              //else
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(model: null)));

            
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 10.0),
                Center(
                    child: Icon(
                  icon,
                  size: 30.0,
                  color: Colors.black87,
                )),
                SizedBox(height: 10.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 17.0, color: Colors.black87)),
                )
              ],
            ),
          ),
        ));
  }
  Card makeDashboardItem(String title, IconData icon) {
    return Card(
      color:Colors.blue[800],
        elevation: 0.01,
        margin: new EdgeInsets.all(3.0),
        child: Container(
          child: new InkWell(
            onTap: () {
              if(title=='Profile')
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));

              else if(title=='Wallet')
              Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard1()));

              //else 
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Shop(model: null)));

            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 15.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.white,
                )),
                SizedBox(height: 15.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 17.0, color: Colors.white)),
                )
              ],
            ),
          ),
        ));
  } 
}