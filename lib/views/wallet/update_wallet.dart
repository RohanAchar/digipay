/*import 'package:digipay_master1/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:flutter/material.dart';

class UpdateWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersWalletStreamSnapshots(context),
        builder: (context,snapshot) {
          if(!snapshot.hasData) 
          {
          print("No data found");
           // return CircularProgressIndicator();
          }
          else{
              Update(context, snapshot);
              return;
              
          }
        }
      ),
    );
  }

  Stream<DocumentSnapshot> getUsersWalletStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).snapshots();
  }

 String Update(context, snapshot)
  {
final user = snapshot.data();
String val = user['user_wallet'];
int bal=int.parse(val);
int result;
result = bal - x;
return result.toString();



  }
      
    
  }




DatabaseReference mDatabase = FirebaseDatabase.getInstance().getReference("QuoteList").child("Quote").child("likes");
        mDatabase.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                long totalLikes =(long) dataSnapshot.getValue();
                mDatabase.setValue(totalLikes + 1);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });


*/
  
