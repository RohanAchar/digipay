import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as v;
//import 'package:digipay_master1/views/mobile recharge/MobileListPage.dart';
import 'package:digipay_master1/views/mobile recharge/global_mobile.dart' as Phoneglobal;
import 'package:digipay_master1/views/wallet/payment.dart';


class PaymentPage extends StatefulWidget {


  final String pID;
  PaymentPage({this.pID});



  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<PaymentPage> {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment"),
      ),
      body: Container(
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.025),
              SizedBox(height: _height * 0.025),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    double c_width = MediaQuery
        .of(context)
        .size
        .width * 0.93;
    //list view
    List<Widget> textFields = [];
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0),
        decoration: buildpaymentPageInputDecoration(
            'Phone No : ${Phoneglobal.phno}'),
        enabled: false, // on saving the value is taken  from the text field
      ),
    );
    textFields.add(
      TextFormField(
        style: TextStyle(color: Colors.blueGrey, fontSize: 22.0),
        decoration:
        buildpaymentPageInputDecoration(
            'Provider :  ${Phoneglobal.providerName}'),
        enabled: false, // on saving the value is taken  from the text field
      ),
    );
    textFields.add(
      Container(
          padding: const EdgeInsets.all(16.0),
          width: c_width,
          child: Column(
            children: <Widget>[
              Text(
                'Plan :  ${Phoneglobal.plan_description}',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
    textFields.add(SizedBox(height: 20));
    return textFields;
  }

  InputDecoration buildpaymentPageInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.black12,
      focusColor: Colors.black12,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
      const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _submitButtonText;

    _submitButtonText = "Pay ${Phoneglobal.amt}";
    return [
      Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.7,
        child: RaisedButton(
          color: Colors.lightBlueAccent,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),

          onPressed: () {
            print(Phoneglobal.amt);
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => PayPage(page: 'recharge')));

          },
        ),
      ),
    ];
  }
}

class PhnoValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    } else if ((value.length != 10) || !(v.isNumeric(value))) {
      return 'Enter a valid 10-Digit phone number';
    }
    return null;
  }
}