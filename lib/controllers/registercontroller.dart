import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class RegisterController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isEmailValid = true;
  bool isPasswordValid = true;
  @override
  void onInit() {
    super.onInit();
  }

  void registerUser() {
    if (isEmailValid && isPasswordValid) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
