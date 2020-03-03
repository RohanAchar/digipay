import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/models/user.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:digipay_master1/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:digipay_master1/models/uid.dart';


class DatabaseService {
  final String uid;

  DatabaseService({this.uid});


  final CollectionReference profileCollection =
      Firestore.instance.collection('users');

  Future updateUserData(
      String name, String phone, String email, String aadhar, String address) async {
    return await profileCollection.document(uid).setData({
      'user_name': name,
      'user_email': email,
      'user_phone': phone,
      'user_aadhar': aadhar,
      'user_address': address,
    });


  }




Stream<UserData> get userData{
    return profileCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}

  Stream<DocumentSnapshot> getUsersprofileSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).snapshots();
  }


UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid:uid,
        name: snapshot.data['user_name'],
        phone: snapshot.data['user_phone'],
        email: snapshot.data['user_email'],
        aadhar: snapshot.data['user_aadhar'],
        address: snapshot.data['user_address'],
        wallet: snapshot.data['user_wallet']


    );
}


Stream<DocumentSnapshot> getProfileData(String uid){
    return profileCollection.document(uid).snapshots();
}

}
