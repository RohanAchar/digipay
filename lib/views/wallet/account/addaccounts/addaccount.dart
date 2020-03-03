import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import './globals.dart' as global;
final scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = new GlobalKey<FormState>();
class AddAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '           ADD ACCOUNT',
      home: Scaffold(
        body: Center(
          child: AddAccounts(),
        ),
      ),
    );
  }
}

// Create a Form widget.
class AddAccounts extends StatefulWidget {
  @override
  AddAccountsState createState() {
    return AddAccountsState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddAccountsState extends State<AddAccounts> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();
  String _accNo;
  String _ifsc;

  bool validate() {
    final form = formKey.currentState; //all the text fields will be set to values
    form.save(); // to save the form
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
  void performSubmit() async {
    //getData();
    if (validate()) {
      try{
        final uid = await Provider.of(context).auth.getCurrentUID();
        await DatabaseService(uid: uid).updateUserAccountData(_accNo, _ifsc);

      }
      catch(e)
    {
      print(e);
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard1()));

    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text("ADD ACCOUNT"),
        ),
        body:  SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: new Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: new Form(
                            key: _formKey,
                            child: new Form(
                              key: formKey,
                              child: new Column(children: <Widget>[
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter Bank Account Number:",
                                      ),
                                      style:TextStyle(
                                        fontSize:17,
                                        color:Colors.black87,
                                      ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter some text';
                                    } 
                                    String p = "[0-9]{11}";
                                   RegExp regExp = new RegExp(p);
                                 if (!regExp.hasMatch(val)||(val.length!=11)) {
                                   // To check if the bank account number is valid
                                 return 'Invalid account number';
                                  }
                                    return null;
                                  },
                                  onSaved: (val) => _accNo = val,
                                ),
                                new Padding(
                                 padding: const EdgeInsets.only(top: 30.0),
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter IFSC Code:"),
                                      style:TextStyle(
                                        fontSize:17,
                                        color:Colors.black87,
                                      ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter some text';
                                    } 
                                    String p="[A-Z]{4}[0-9]{7}";
                                    RegExp regExp = new RegExp(p);
                                  if (!regExp.hasMatch(val)||(val.length!=11)) {
                                   // To check if the bank account number is valid
                                 return 'Invalid IFSC number';
                                  }
                                    return null;
                                  },
                                  onSaved: (val) => _ifsc = val,
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                                new RaisedButton(
                                  child: new Text("Save",
                                  style:TextStyle(
                                    fontSize:20,
                                    color:Colors.black54,
                                  )),
                                  onPressed: performSubmit,
                                ),
                              ]),
                            ))))));
  }
}

/*
//import 'package:flutter/material.dart';
//import './globals.dart' as global;
final scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = new GlobalKey<FormState>();
class AddAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '           ADD ACCOUNT',
      home: Scaffold(
        body: Center(
          child: AddAccounts(),
        ),
      ),
    );
  }
}

// Create a Form widget.
class AddAccounts extends StatefulWidget {
  @override
  AddAccountsState createState() {
    return AddAccountsState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddAccountsState extends State<AddAccounts> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  void performSubmit() {
    //getData();

    if (formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text("ADD ACCOUNT"),
        ),
        body:  SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: new Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: new Form(
                            key: _formKey,
                            child: new Form(
                              key: formKey,
                              child: new Column(children: <Widget>[
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter Bank Account Number:",
                                      ),
                                      style:TextStyle(
                                        fontSize:17,
                                        color:Colors.black87,
                                      ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter some text';
                                    } 
                                    String p = "[0-9]{11}";
                                   RegExp regExp = new RegExp(p);
                                 if (!regExp.hasMatch(val)||(val.length!=11)) {
                                   // To check if the bank account number is valid
                                 return 'Invalid account number';
                                  }
                                    return null;
                                  },
                                  onSaved: (val) => global.accNo = val,
                                ),
                                new Padding(
                                 padding: const EdgeInsets.only(top: 30.0),
                                ),
                                new TextFormField(
                                  decoration: new InputDecoration(
                                      labelText: "Enter IFSC Code:"),
                                      style:TextStyle(
                                        fontSize:17,
                                        color:Colors.black87,
                                      ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please enter some text';
                                    } 
                                    String p="[A-Z]{4}[0-9]{7}";
                                    RegExp regExp = new RegExp(p);
                                  if (!regExp.hasMatch(val)||(val.length!=11)) {
                                   // To check if the bank account number is valid
                                 return 'Invalid IFSC number';
                                  }
                                    return null;
                                  },
                                  onSaved: (val) => global.ifsc = val,
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                                new RaisedButton(
                                  child: new Text("Save",
                                  style:TextStyle(
                                    fontSize:20,
                                    color:Colors.black54,
                                  )),
                                  onPressed: performSubmit,
                                ),
                              ]),
                            ))))));
  }
}*/