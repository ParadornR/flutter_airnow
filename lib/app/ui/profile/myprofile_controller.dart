import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/data/providers/user_provider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyprofileController extends GetxController {
  final userProvider = Get.find<UserProvider>();
  var nameController = TextEditingController().obs;
  var mailController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var isEdited = false.obs;
  var urlNetwork = "".obs;

  @override
  void onInit() {
    loadData();
    
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<MyprofileController>();
    super.onClose();
  }

  void loadData() {
    nameController.value.text = userProvider.user.value!.name;
    mailController.value.text = userProvider.user.value!.email;
    phoneController.value.text = userProvider.user.value!.phone;
    urlNetwork = userProvider.user.value!.urlImage.obs;
    // log(nameController.value.text);
    // log(mailController.value.text);
    // log(phoneController.value.text);
  }

  Future<void> saveData() async {
    await uploadImage();
    String? userId = await _getUserIdFromSharedPreferences();
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': nameController.value.text,
        'phone': phoneController.value.text,
        'urlImage': urlNetwork.value,
      });
      userProvider.fetchUserData();
      log('อัปเดตข้อมูลเรียบร้อยแล้ว');
    } catch (e) {
      log('เกิดข้อผิดพลาด: $e');
    }
  }

  Future<String?> _getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  var image = Rxn<XFile>(); // Rxn = รองรับค่า null
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = pickedImage;
    }
  }

  Future<void> uploadImage() async {
    log("uploadImage()");
    if (urlNetwork == urlNetwork) return;
    if (image.value == null) return;

    final String fileName =
        'UserProfileImages/${DateTime.now().millisecondsSinceEpoch}.png';
    final Reference ref = _storage.ref().child(fileName);

    try {
      await ref.putFile(File(image.value!.path));
      urlNetwork.value = await ref.getDownloadURL();
    } catch (e) {
      log("Error uploading image: $e");
    }
  }
}
