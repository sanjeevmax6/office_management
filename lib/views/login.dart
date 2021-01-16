import 'package:flutter/material.dart';
import 'package:office_management/services/auth.dart';
import 'package:office_management/views/adminpage.dart';
import 'package:office_management/views/home.dart';
import 'package:office_management/widgets/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signIn(){
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      authMethods.signInWithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text).then((value) {
        if(value != null){
          print("success");
          if(emailTextEditingController.text == "sanvegas2001@gmail.com" && passwordTextEditingController.text == "Admin123"){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => AdminPage()
            ));
          }
          else{
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Home()
            ));
          }

        }
      });


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(
            child: CircularProgressIndicator()
        ),
      ) : Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: "Email" ,
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

                      onChanged: (mail) {

                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        return value.length > 6 ? null :  "Password should have more than 6 characters";
                      },
                      controller: passwordTextEditingController,
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: "Password" ,
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

                      },
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                signIn();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.lightGreenAccent,
                        Colors.green
                      ]
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text("Login", style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

