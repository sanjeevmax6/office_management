import 'package:flutter/material.dart';
import 'package:office_management/services/auth.dart';
import 'package:office_management/services/database.dart';
import 'package:office_management/views/login.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

//class Levels {
//  int id;
//  int level;
//
//  Levels(this.id, this.level);
//
//  static List<Levels> getLevels() {
//    return <Levels>[
//      Levels(1, 1),
//      Levels(2, 2),
//      Levels(3, 3),
//      Levels(4, 4),
//      Levels(5, 5),
//    ];
//  }
//}

class _AdminPageState extends State<AdminPage> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController departmentTextEditingController = new TextEditingController();

  var _levels = ['1', '2', '3', '4', '5'];
  var selectedLevel = '1';
  var inputEmail;
  var inputPassword;
  bool isLoading = false;

//  List<Levels> _levels = Levels.getLevels();
//  List<DropdownMenuItem<Levels>> _dropdownMenuItems;

  signup() {
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(inputEmail, inputPassword).then((value)  {
        print("$value");
        print("Data Added Successfully");

        Map<String, String> userInfoMap = {
          "email": emailTextEditingController.text,
          "username": usernameTextEditingController.text,
          "level": selectedLevel,
          "department": departmentTextEditingController.text,
          "admin": "n",


        };
        databaseMethods.uploadUserInfo(userInfoMap).then((value) {
          print("Data added to firestore");



        });
      });
    }

  }

//  closeModalBottomSheet() {
//    Navigator.of(context).pop();
//  }

//  @override
//  void initState() {
//    // TODO: implement initState
//    databaseMethods.getUserByAdminPermission();
//    super.initState();
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Office Management", style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => SignIn()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Container(

      ),
      floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          child: new Icon(Icons.verified_user),
          backgroundColor: Colors.lightGreen,
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (BuildContext buildContext) {
              return SingleChildScrollView(
                child: Container(
//                  height: MediaQuery
//                      .of(context)
//                      .size
//                      .height ,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: TextFormField(
                                    validator: (value){
                                      return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)
                                          ? null : "Invalid Email";
                                    },
                                    controller: emailTextEditingController,
                                    obscureText: false,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                        color: Colors.greenAccent,
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ),

                                    onChanged: (email) {
                                      inputEmail = email;
                                      print(inputEmail);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: TextFormField(
                                    validator: (value) {
                                      return value.length < 0 ? null : "Invalid Username";
                                    },
                                    controller: usernameTextEditingController,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: "Username",
                                      labelStyle: TextStyle(
                                        color: Colors.greenAccent,
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ),

                                    onChanged: (password) {
                                      inputPassword = password;
                                      print(inputPassword);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: TextFormField(
                                    validator: (value) {
                                      return value.length < 0 ? null : "Invalid Department";
                                    },
                                    controller: departmentTextEditingController,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: "Department",
                                      labelStyle: TextStyle(
                                        color: Colors.greenAccent,
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ),

                                    onChanged: (password) {
                                      inputPassword = password;
                                      print(inputPassword);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  child: TextFormField(
                                    validator: (value) {
                                      return value.length < 0 ? null : "Invalid Password";
                                    },
                                    enabled: true,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        color: Colors.greenAccent,
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ),

                                    onChanged: (password) {
                                      inputPassword = password;
                                      print(inputPassword);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Choose Level", style: TextStyle(
                                  fontSize: 15,
                                ),),
                              ),
                              DropdownButton<String>(
                                items: _levels.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),

                                onChanged: (String newValueSelected) {
                                  setState(() {
                                    selectedLevel = newValueSelected;
                                    print(selectedLevel);
                                  });
                                },
                                value: selectedLevel,
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              signup();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.lightGreenAccent,
                                        Colors.green
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Text("Add User", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),),
                            ),
                          )


                        ],
                      )
                  ),
                ),
              );
            });
          }
      ),
    );
  }
}

