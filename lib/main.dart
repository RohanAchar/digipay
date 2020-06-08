import 'package:digipay_master1/models/uid.dart';
import 'package:digipay_master1/views/shopping_cart/cartpage.dart';
import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'views/dashboard.dart';
import 'package:digipay_master1/views/first_view.dart';
import 'package:digipay_master1/views/sign_up_view.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:digipay_master1/services/auth_service.dart';
import 'views/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: "Payment App",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext context) => HomeController(),
          '/cart': (BuildContext context) => CartPage(),
          '/dashboard': (BuildContext context) => Dashboard()

        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    //setUID(context);
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
           if(signedIn) {
             return Dashboard();
           }
           else{
             return FirstView();
           }

        }
        return CircularProgressIndicator();
      },
    );
  }
void setUID(BuildContext context) async {
  final uid = await Provider
      .of(context)
      .auth
      .getCurrentUID();
  current_user_uid = uid;

}

}

