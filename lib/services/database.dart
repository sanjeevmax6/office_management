import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethods{

  uploadUserInfo(userMap) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add(userMap);
  }

//  getUserByUserEmail(String userEmail) async {
//    CollectionReference users = FirebaseFirestore.instance.collection('users');
//    return await users.where("email", isEqualTo: userEmail )
//        .getDocuments();
//  }
}