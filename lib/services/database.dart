import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethods{

  uploadUserInfo(userMap) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add(userMap);
  }

  getUserByAdminPermission() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        return doc["admin"];
      })
    });
  }
  getUserByEmail() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        return doc["email"];
      })
    });
  }

  getUserNameByEmail(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.get().then((querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        if(doc["email"] == email){
          return doc["username"];
        }
      })
    });
  }
  getUserLevelByEmail(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.get().then((querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        if(doc["email"] == email){
          return doc["level"];
        }
      })
    });
  }
  getUserDepartmentByEmail(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.get().then((querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        if(doc["email"] == email){
          return doc["department"];
        }
      })
    });
  }
  addFiles(messageMap) async {
    CollectionReference users = FirebaseFirestore.instance.collection('filestorage');
    users.add(messageMap).catchError((error) {
      print(error.toString());
    });
  }

//  getUserByUserEmail(String userEmail) async {
//    CollectionReference users = FirebaseFirestore.instance.collection('users');
//    return await users.where("email", isEqualTo: userEmail )
//        .getDocuments();
//  }
}