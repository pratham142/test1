import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/home.dart';
import 'package:test1/login.dart';

class authpage extends StatefulWidget {
  const authpage({super.key});

  @override
  State<authpage> createState() => _authpageState();
}

class _authpageState extends State<authpage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder <User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        if (snapshot.hasData) {
          return homepage();
        }else{return LoginScreen();}
      },),
    );
  }
}