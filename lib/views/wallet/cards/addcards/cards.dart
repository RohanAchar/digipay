/*import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
//import 'package:mastering_payments/provider/user_provider.dart';
//import 'package:mastering_payments/screens/home.dart';
//import 'package:mastering_payments/services/functions.dart';
//import 'package:mastering_payments/services/stripe.dart';
//import 'package:provider/provider.dart';

class CreditCard extends StatefulWidget {
  CreditCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused, //true when you want to show cvv(back) view
              ),
              CreditCardForm(
                themeColor: Colors.red,
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvFocused = data.isCvvFocused;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          int cvc = int.tryParse(cvvCode);
          int carNo = int.tryParse(cardNumber.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
          int exp_year = int.tryParse(expiryDate.substring(3,5));
          int exp_month = int.tryParse(expiryDate.substring(0,2));

          print("cvc num: ${cvc.toString()}");
          print("card num: ${carNo.toString()}");
          print("exp year: ${exp_year.toString()}");
          print("exp month: ${exp_month.toString()}");
          print(cardNumber.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
//
//          StripeServices stripeServices = StripeServices();
//          if(user.userModel.stripeId == null){
//           String stripeID = await stripeServices.createStripeCustomer(email: user.userModel.email, userId: user.user.uid)
//          stripeServices.addCard(stripeId: stripeID, month: exp_month, year: exp_year, cvc: cvc, cardNumber: carNo);
//          }


          //changeScreen(context, HomeScreen());

        },
        tooltip: 'Submit',
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/

import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:digipay_master1/views/wallet/cards/addcards/credit_card_form.dart';
import 'package:digipay_master1/views/wallet/cards/addcards/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:string_validator/string_validator.dart' as v;

final scaffoldKey5 = new GlobalKey<ScaffoldState>();
final formKey5 = new GlobalKey<FormState>();

/*void main() => runApp(MySample());

class MySample extends StatefulWidget {
  @override/
  State<StatefulWidget> createState() {
    return MySampleState();
  }
}

class MySampleState extends State<MySample> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;*/

class CreditCard extends StatefulWidget {
  CreditCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  /*void performSave1() {
    if(validate())
    {
       Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard1()));
    }
    
  }*/
  void performSave() async {
    //getData();
    if (validate()) {
      try{
        final uid = await Provider.of(context).auth.getCurrentUID();
        await DatabaseService(uid: uid).updateUserCardData(cardNumber,expiryDate,cvvCode,cardHolderName);

      }
      catch(e)
    {
      print(e);
      scaffoldKey5.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard1()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
              new RaisedButton(
                                  child: new Text("Save"),
                                  onPressed: performSave,
                                )
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}