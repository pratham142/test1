import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  File? selectedImage;

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageFile = File(image.path);
      selectedImage = imageFile;
      print('image path is - ${image.path}');
      update();
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void saveProfile() {
    print(nameController.text);
    print(bioController.text);
    print(emailController.text);
  }
}
