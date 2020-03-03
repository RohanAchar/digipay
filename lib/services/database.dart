import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/models/user.dart';



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

  Future updateWalletData(String wallet) async {
    return await profileCollection.document(uid).setData({
      'user_wallet': wallet,
    });
  }





Stream<UserData> get userData{
    return profileCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}

// get the user data
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid:uid,
        name: snapshot.data['user_name'],
        phone: snapshot.data['user_phone'],
        email: snapshot.data['user_email'],
        aadhar: snapshot.data['user_aadhar'],
        address: snapshot.data['user_address']


    );
}



Stream<DocumentSnapshot> getProfileData(String uid){
    return profileCollection.document(uid).snapshots();
}

Future updateUserCardData(
      String cardno, String exp, String cvv, String name) async {
    return await profileCollection.document(uid).collection('cards').document().setData({
      'card_no': cardno,
      'card_exp': exp,
      'card_cvv': cvv,
      'card_name': name,
    });
  }
Future updateUserAccountData(
      String accNo, String ifsc) async {
    return await profileCollection.document(uid).collection('Account').document().setData({
      'account_no': accNo,
      'account_ifsc':ifsc
    });
  }



Stream<QuerySnapshot> requestDocuments(){
    return profileCollection.document(uid).collection('cards').snapshots();
}
}