import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:get/get.dart';

class MyprofileController extends GetxController {
  final userProvider = Get.find<UserProvider>();
  var nameController = TextEditingController().obs;
  var mailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var isEdited = false.obs;
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() {
    nameController.value.text = userProvider.user.value!.name;
    mailController.value.text = userProvider.user.value!.email;
    phoneController.value.text = userProvider.user.value!.phone;

    log(nameController.value.text);
    log(mailController.value.text);
    log(phoneController.value.text);
  }
}
