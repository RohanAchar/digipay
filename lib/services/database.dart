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

//  Stream<DocumentSnapshot> get profile {
//
////    print("database class :$uid");
////    DocumentReference docRef = await
////         Firestore.instance.collection('user_profiles').document(uid);
////    await docRef.get().then((DocumentSnapshot datasnapshot) {
////      if (datasnapshot.exists) {
////
////       String u;
////       String s;
////       String e;
////       String p;
////        u=datasnapshot.data['user_name'];
////        s=datasnapshot.data['user_status'];
////        p=datasnapshot.data['user_phone'];
////        e=datasnapshot.data['user_email'];
////
////        User_Profile up=new User_Profile(u,s,p,e);
////        print(datasnapshot.data);
////
////        return profileCollection.document((uid));
////
////      }
////      else{
////        print("document not found");
////        return null;
////      }
//
//
////
//  return profileCollection.document()
//
//  }

  //hallo Stream



Stream<UserData> get userData{
    return profileCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}


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

}
