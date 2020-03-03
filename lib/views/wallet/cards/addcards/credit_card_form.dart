import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/wallet/wallet.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'credit_card_model.dart';
import 'package:string_validator/string_validator.dart' as v;

final scaffoldKey = new GlobalKey<ScaffoldState>();
final formKey = new GlobalKey<FormState>();

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    Key key,
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    @required this.onCreditCardModelChange,
    this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final void Function(CreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  Color themeColor;

  /*void performSave() async {
    //getData();
    if (validate()) {
      try{
        final uid = await Provider.of(context).auth.getCurrentUID();
        await DatabaseService(uid: uid).updateUserCardData(cardNumber,expiryDate,cvvCode,cardHolderName);

      }
      catch(e)
    {
      print(e);
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data')));
    }
    Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard1()));

    }
  }*/

  void Function(CreditCardModel) onCreditCardModelChange;
  CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber ?? '';
    expiryDate = widget.expiryDate ?? '';
    cardHolderName = widget.cardHolderName ?? '';
    cvvCode = widget.cvvCode ?? '';

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor ?? Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: themeColor.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: TextFormField(
                validator: CardnoValidator.validate,
                controller: _cardNumberController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card number',
                  hintText: 'xxxx xxxx xxxx xxxx',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onSaved: (value) => cardNumber = value,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: TextFormField(
                validator: MonthValidator.validate,
                controller: _expiryDateController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'MM/YY'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: TextFormField(
                validator: CvvValidator.validate,
                focusNode: cvvFocusNode,
                controller: _cvvCodeController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  hintText: 'XXXX',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (String text) {
                  setState(() {
                    cvvCode = text;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
              child: TextFormField(
                validator: CardHolderValidator.validate,
                controller: _cardHolderNameController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Holder',
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
      ),
    );
  }
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

class CardnoValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Card number can't be empty";
    }
    if (value.length < 19) {
      return "Enter a 16 digit card number";
    }
    String p = "(^4)|(^34)|(^37)|(^6011)|(^622126)|(^622925)|(^644)|(^649)|(^65)|(^51)|(^55)|(^2221)|(^2229)|(^223)|(^229)|(^23)|(^26)|(^270)|(^271)|(^2720)[0-9]";
    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      // To check if the bank account number is valid
      return 'Invalid card number';
    }
    return null;
  }
}

class MonthValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Expired Date can't be empty";
    }
    String p = "(0{1}[1-9]{1})|(1{1}[0-2]{1})/(2{1}[1-9]{1})|([3-9]{1}[0-9]{1})";
    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      // To check if the bank account number is valid
      return 'Expiry Date Invalid';
    }
    return null;
  }
}

class CvvValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "CVV can't be empty";
    }
    if (value.length !=4) {
      return "Enter a 4 digit CVV";
    }
    return null;
  }
}

class CardHolderValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Card Holder can't be empty";
    }
    return null;
  }
}
