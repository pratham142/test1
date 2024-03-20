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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.11,
                  backgroundColor: const Color.fromARGB(255, 230, 150, 150),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.person_2_rounded,
                        size: 150,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.13,
                        left: MediaQuery.of(context).size.height * 0.11,
                        child: CircleAvatar(
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
                                          onPressed: () {},
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
              SizedBox(
                height: 50,
              ),
              defaulttextfield(
                controller: controller.nameController,
                text: 'name',
              ),
              defaulttextfield(
                controller: controller.emailController,
                text: FirebaseAuth.instance.currentUser!.email.toString(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat(textFormat).format(pickedDate);
                      print(formattedDate);

                      text = formattedDate;
                    } else {}
                  },
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
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  controller.saveProfile();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.050,
                  width: MediaQuery.of(context).size.height * 0.3,
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
