import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/profile/myprofile_controller.dart';
import 'package:flutter_airnow/app/ui/widget/custom_text.dart';
import 'package:get/get.dart';

class MyprofilePage extends StatefulWidget {
  const MyprofilePage({super.key});

  @override
  State<MyprofilePage> createState() => _MyprofilePageState();
}

class _MyprofilePageState extends State<MyprofilePage> {
  final myProfileController = Get.put(MyprofileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
            centerTitle: true,
            actions: [
              Obx(
                () => SizedBox(
                  child:
                      myProfileController.isEdited.value
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                myProfileController.isEdited.value =
                                    !myProfileController.isEdited.value;
                                log(
                                  "actions:${myProfileController.isEdited.value}",
                                );
                                myProfileController.saveData();
                              },
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                myProfileController.isEdited.value =
                                    !myProfileController.isEdited.value;
                                log(
                                  "actions:${myProfileController.isEdited.value}",
                                );
                              },
                            ),
                          ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Stack(
                    children: [
                      Center(
                        child: Obx(
                          () => CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.15,
                            backgroundColor: Theme.of(context).primaryColor,
                            child:
                                myProfileController.image.value != null
                                    ? CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                          0.14,
                                      backgroundImage: FileImage(
                                        File(
                                          myProfileController.image.value!.path,
                                        ),
                                      ),
                                    )
                                    : myProfileController
                                        .urlNetwork
                                        .value
                                        .isEmpty
                                    ? Icon(Icons.person, size: 48)
                                    : CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                          0.14,
                                      backgroundImage: NetworkImage(
                                        myProfileController.urlNetwork.value,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                      Center(
                        child: Obx(
                          () => Visibility(
                            visible: myProfileController.isEdited.value,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              widthFactor:
                                  MediaQuery.of(context).size.width * 0.0065,
                              heightFactor:
                                  MediaQuery.of(context).size.width * 0.0065,
                              child: InkWell(
                                onTap: () {
                                  log("edit picture");
                                  myProfileController.pickImage();
                                },
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey.shade300,
                                    child: Icon(
                                      Icons.image,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 16),
                            CustomText(text: "Name", size: 16),
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Obx(
                          () => TextField(
                            controller:
                                myProfileController.nameController.value,
                            readOnly: !myProfileController.isEdited.value,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.mail),
                            SizedBox(width: 16),
                            CustomText(text: "Email", size: 16),
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: TextField(
                          controller: myProfileController.mailController.value,
                          readOnly: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.phone),
                            SizedBox(width: 16),
                            CustomText(text: "Phone", size: 16),
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFA3E4FA), Color(0xFFD1F8EF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Obx(
                          () => TextField(
                            controller:
                                myProfileController.phoneController.value,
                            readOnly: !myProfileController.isEdited.value,
                            decoration: InputDecoration(
                              hintText: "XXX-XXX-XXXX",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
