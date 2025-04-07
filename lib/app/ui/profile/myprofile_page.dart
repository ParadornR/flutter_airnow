import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/profile/widget/custom_field.dart';

class MyprofilePage extends StatefulWidget {
  const MyprofilePage({super.key});

  @override
  State<MyprofilePage> createState() => _MyprofilePageState();
}

class _MyprofilePageState extends State<MyprofilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isEdited = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            centerTitle: true,
            actions: [
              isEdited
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        isEdited = !isEdited;
                        setState(() {});
                      },
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        isEdited = !isEdited;
                        setState(() {});
                      },
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
                        child: CircleAvatar(
                          radius: 48,
                          child: Icon(Icons.person, size: 32),
                        ),
                      ),
                      Center(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          widthFactor: 2.5,
                          heightFactor: 2.5,
                          child: InkWell(
                            onTap: () {
                              log("edit picture");
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.image),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomField(
                    icon: Icons.person,
                    title: 'Name',
                    controller: nameController,
                  ),
                  SizedBox(height: 8),
                  CustomField(
                    icon: Icons.person,
                    title: 'Email',
                    controller: mailController,
                  ),
                  SizedBox(height: 8),
                  CustomField(
                    icon: Icons.person,
                    title: 'Phone',
                    controller: phoneController,
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
