import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Collection extends StatefulWidget {
  @override
  _Collection createState() => _Collection();
}
class _Collection extends State {
  String msg = 'Click to create collections';

  Firestore _firestore = Firestore.instance;

bool enable =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text('DigiPay Developer'),

      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                msg,
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              RaisedButton(
                child: Text("Rock & Roll Soniye"),
                onPressed: enable? performSubmit : null,
                color: Colors.blue,
                textColor: Colors.black,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  void performSubmit() async {
    enable=false;

    //Mobile recharge collection
    final List<String> operators = ['Airtel','BSNL','Jio','Vodaphone'];
    final List price = [[399,559],[259],[1199,349,598],[48,279]];
    final List plan = [['Rs399=Unlimited calls to all network with daily 2GB data and 100 SMS for 56 days.',
                              'Rs559=Unlimited calls to all network with daily 1.5GB data and 100 SMS for 84 days.'],
    ['Rs259=Unlimited calls to all network with daily 3GB data and 100 SMS for 28 days.'],
    ['Rs1199=Jio International Roaming, 100 minutes Incoming and Outgoing calls with 1GB data for 30 days.',
    'Rs349=Amazon Prime Subscription + Unlimited calls to all networks with daily 2GB data and 100 SMS for 28 days.',
    'Rs598=Unlimited calls to all network with daily 1.5GB data and 100 SMS for 90 days.'],
    ['Rs48=3GB data pack with validity of 28 days.',
    'Rs279=Unlimited calls to all network with daily 1GB data and 100 SMS for 36 days.']];
  DocumentReference mobile_id,movie_id,theatre_id,promo_id;
    try {
    /*  for(int i=0;i<operators.length;i++) {
          mobile_id =  await _firestore.collection('mobile recharge').add({
          'name': operators[i],

        });
     for(int j=0;j<price[i].length;j++) {
       await _firestore.collection('mobile recharge').document(
           mobile_id.documentID).collection('plans').add({
         'plan_amt': price[i][j],
         'plan_description': plan[i][j]
       });
     }

      }  */
      // Movie collection
      final List movies = [['Brahmastra','10th Oct','U/A'],['Black Widow','24th May','U/A'],['Karwaan','13th July','U']];
      final List theatres = [['Big Cinemas','PVR Kormangala'],['Balaji 2K cinemas','INOX Mantri'],['Cinepolis']];

      for(int i=0;i<movies.length;i++) {
        movie_id =  await _firestore.collection('movie').add({
          'movie_certification': movies[i][2],
          'movie_date': movies[i][1],
        'movie_name': movies[i][0]


        });
        for(int j=0;j<theatres[i].length;j++) {
          theatre_id = await _firestore.collection('movie').document(
              movie_id.documentID).collection('theatres').add({
            'theatre_name': theatres[i][j],

          });
        }

      }

  /*   //promo codes
      final List<String> promo = ['movie_codes','recharge_codes','shopping_codes'];
      final List amt = [[100],[150,100,24,20],[99]];
      final List des = [['This gives you a Rs100 off'],['Nemm mane pataki na namm udinKaddi dinda hacchi','Pheww! Me flat','This gives you a 24 off','Rs20 free pataki for Diwali '],['Rs99 Off']];
      final List name = [['SR100'],['UdinKaddi','RohanRocks','Bingo','Pataki20'],['Super99']];


      promo_id = await _firestore.collection('promo codes').add({
        //creating an empty document
      });
      for(int i = 0;i<promo.length;i++) {
        for (int j = 0; j < amt[i].length; j++) {
          await _firestore.collection('promo codes').document(
              promo_id.documentID).collection(promo[i]).add({
            'amt': amt[i][j],
            'promo_des': des[i][j],
            'promo_name': name[i][j],
          });
        }
      } */
      }
      catch (e) {
        print(e);

      }

  }
}
