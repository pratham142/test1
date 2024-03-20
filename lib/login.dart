import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/register.dart';
import 'package:test1/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailValid = true;

  void validateEmail(String email) {
    setState(() {
      isEmailValid = EmailValidator.validate(email);
    });
  }

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong password provided for that user.')),
        );
      } else if (e.code == 'wrong-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wrong Email provided for that user.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 200,
                ),
                SizedBox(height: 100),
                SizedBox(
                  height: 100,
                  child: Emailvalidationtextfield(
                      emailController: emailController),
                ),
                SizedBox(height: 15),
                Passwordvalidationtextfield(
                    passwordController: passwordController),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
                    );
                  },
                  child: Text('Register Now'),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    if (isEmailValid) {
                      signIn();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber,
                    ),
                    height: 50,
                    width: 150,
                    child: Center(child: Text('Login')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
