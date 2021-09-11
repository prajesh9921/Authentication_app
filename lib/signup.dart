import 'package:flutter/material.dart';
import 'package:notes/home.dart';
import 'package:notes/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF880e4f),
        appBar: AppBar(
            backgroundColor: Color(0xFF560027),
            title: Text("Sign Up Page", style: TextStyle(color: Colors.white),),
            centerTitle: true,
          ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFbc477b),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFbc477b),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    onChanged: (value){
                      email = value;
                      print(email);
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFbc477b),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: TextField(
                    onChanged: (value){
                      password = value;
                      print(password);
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              SizedBox(
                height: 15.0,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF560027),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0)
                  ),
                    onPressed: () async{
                      FocusScope.of(context).unfocus();
                      try {
                        final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if(newUser != null){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        ScaffoldMessenger.of(context)
                          .showSnackBar(new SnackBar(content: new Text("The password provided is too weak.")));
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        ScaffoldMessenger.of(context)
                          .showSnackBar(new SnackBar(content: new Text("The account already exists for that email.")));
                      }
                    } catch (e) {
                      print(e);
                    }
                    },
                    child: Text("Sign Up", style: TextStyle(color: Colors.white),)
                ),
              SizedBox(height: 10.0,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Login", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),),
                )
            ],
          ),
        ),
      ),
    );
  }
}
