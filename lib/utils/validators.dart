import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Emailvalidationtextfield extends StatefulWidget {
  final TextEditingController emailController;

  const Emailvalidationtextfield({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  _EmailvalidationtextfieldState createState() =>
      _EmailvalidationtextfieldState();
}

class _EmailvalidationtextfieldState extends State<Emailvalidationtextfield> {
  bool isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.emailController,
        decoration: InputDecoration(
          hintText: 'User Email',
          errorText: isEmailValid ? null : 'Invalid email address',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onSubmitted: (_) {
          setState(() {
            isEmailValid = EmailValidator.validate(widget.emailController.text);
          });
        },
      ),
    );
  }
}

class Passwordvalidationtextfield extends StatefulWidget {
  final TextEditingController passwordController;

  const Passwordvalidationtextfield({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  _PasswordvalidationtextfieldState createState() =>
      _PasswordvalidationtextfieldState();
}

class _PasswordvalidationtextfieldState
    extends State<Passwordvalidationtextfield> {
  bool isPasswordValid = true;
  void validate(String mail) {
    isPasswordValid = mail.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.passwordController,
        decoration: InputDecoration(
          hintText: 'Password',
          errorText:
              isPasswordValid ? null : 'Password must be at least 6 characters',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onChanged: (_) {
          setState(() {
            isPasswordValid = widget.passwordController.text.length >= 6;
          });
        },
        obscureText: true,
      ),
    );
  }
}

class defaulttextfield extends StatefulWidget {
  TextEditingController controller;
  String text;
  String? hintText = '';

  defaulttextfield(
      {super.key, required this.controller, required this.text, this.hintText});

  @override
  State<defaulttextfield> createState() => _defaulttextfieldState();
}

class _defaulttextfieldState extends State<defaulttextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            label: Text(widget.text),
            hintText: widget.hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
