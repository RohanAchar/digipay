import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:digipay_master1/views/shopping_cart/cartmodel.dart';
import 'package:digipay_master1/views/shopping_cart/cartpage.dart';
import 'package:digipay_master1/views/shopping_cart/home.dart';
import 'package:digipay_master1/views/shopping_cart/dropdown.dart';

class Shop extends StatelessWidget{

  final CartModel model;

  const Shop({Key key, @required this.model}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<CartModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        home: DropDown(),
        routes: {'/cart': (context) => CartPage()},
      ),
    );
  }
}