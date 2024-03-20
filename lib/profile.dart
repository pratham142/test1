import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test1/controllers/profilecontroller.dart';
import 'package:test1/controllers/registercontroller.dart';
import 'package:test1/utils/validators.dart';

class Profilescreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    final RegisterController registerController = Get.put(RegisterController());
    String? text;
    String textFormat = 'yyyy-MM-dd';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Center(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.11,
                    backgroundColor: const Color.fromARGB(255, 230, 150, 150),
                    child: Stack(
                      children: [
                        if (controller.selectedImage.value != null)
                          ClipOval(
                            child: Image.file(
                              controller.selectedImage.value!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.openCamera();
                                            },
                                            child: Text('Open Camera'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.pickImage();
                                            },
                                            child: Text('Open gallery'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              defaulttextfield(
                controller: controller.nameController,
                text: 'Name',
                hintText: controller.username,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: FirebaseAuth.instance.currentUser?.email ?? '',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.datecontroller,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: controller.datecontroller.text.isNotEmpty
                          ? DateFormat(textFormat)
                              .parse(controller.datecontroller.text)
                          : DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat(textFormat).format(pickedDate);
                      controller.datecontroller.text = formattedDate;
                    }
                  },
                  readOnly:
                      true, // Make the text field readonly to prevent manual input
                  decoration: InputDecoration(
                    labelText: 'Date Of Birth',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              defaulttextfield(
                controller: controller.bioController,
                text: 'Bio',
                hintText: controller.bio,
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  controller.saveProfile();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orange,
                  ),
                  child: Center(child: Text('Save')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
