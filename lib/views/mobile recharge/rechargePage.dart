import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as v;
import 'package:digipay_master1/views/mobile recharge/MobileListPage.dart';
import 'package:digipay_master1/views/mobile recharge/global_mobile.dart' as Phoneglobal;





class RechargePage extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<RechargePage> {

  final formKey = GlobalKey<FormState>();
  String _phno, _warning;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: Text("Mobile Recharge"),

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


  List<Widget> buildInputs() {    //list view
    List<Widget> textFields = [];
    textFields.add(
      TextFormField(
        validator: PhnoValidator.validate,
        style: TextStyle(fontSize: 22.0),
        keyboardType: TextInputType.number,
        decoration: buildRechargePageInputDecoration("Enter Phone Number"),
        onSaved: (value) => _phno = value,
      ),
    );
    textFields.add(SizedBox(height: 20));
    return textFields;
  }

  InputDecoration buildRechargePageInputDecoration(String hint) {
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

    _submitButtonText = "Choose Provider";
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: submit,

        ),
      ),

    ];
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

  void submit() async { //to interact with the firebase fn we made in our auth service
    if (validate()) {
      try {
        Phoneglobal.phno = _phno;
        Navigator.push(context, MaterialPageRoute(builder: (context) => MobileListPage(phno: _phno,)));
      } catch (e) {
        print(e);

      }
    }
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




