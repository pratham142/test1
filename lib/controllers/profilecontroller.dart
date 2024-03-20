import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final storage = GetStorage();
    nameController.text = storage.read('username') ?? '';
    bioController.text = storage.read('bio') ?? '';
    datecontroller.text = storage.read('dob') ?? '';

    final imagePath = storage.read('image') ?? '';
    if (imagePath.isNotEmpty) {
      selectedImage.value = File(imagePath);
    }
  }

  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final datecontroller = TextEditingController();
  var username = 'name';
  var bio = 'bio';
  var selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageFile = File(image.path);
      selectedImage.value = imageFile;
      print('image path is - ${image.path}');
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> openCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageFile = File(image.path);
      selectedImage.value = imageFile;
      print('image path is - ${image.path}');
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void saveProfile() {
    final storage = GetStorage();
    storage.write('username', nameController.text);
    storage.write('bio', bioController.text);
    storage.write('dob', datecontroller.text);

    if (selectedImage.value != null) {
      storage.write('image', selectedImage.value!.path);
    } else {
      storage.remove('image');
    }
  }
}
