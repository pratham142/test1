import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/controllers/registercontroller.dart';
import 'package:test1/utils/validators.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.app_registration,
                  size: 250,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Emailvalidationtextfield(
                        emailController: controller.email)),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Passwordvalidationtextfield(
                        passwordController: controller.password)),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    controller.registerUser();
                    Navigator.pop(context);
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
