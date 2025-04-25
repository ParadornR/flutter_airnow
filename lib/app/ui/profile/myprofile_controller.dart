import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_airnow/app/ui/home/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyprofileController extends GetxController {
  final userController = Get.find<UserController>();
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
    nameController.value.text = userController.user.value!.name;
    mailController.value.text = userController.user.value!.email;
    phoneController.value.text = userController.user.value!.phone;
    urlNetwork = userController.user.value!.urlImage.obs;
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
      userController.fetchUserData();
      Get.snackbar(
        'Profile Updated',
        "Your profile information has been successfully updated.",
                margin: EdgeInsets.all(8),
        backgroundColor: Color.fromRGBO(76, 175, 80, 1),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Update Failed',
        "An error occurred while updating your profile. Please try again later.",
        margin: EdgeInsets.all(8),
        backgroundColor: Color.fromRGBO(76, 175, 80, 1),
        colorText: Colors.white,
      );
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
    // if (urlNetwork == userController.user.value!.urlImage.obs) return;
    if (image.value == null) return;
    String? oldImageUrl = userController.user.value!.urlImage;

    final String fileName =
        'UserProfileImages/${DateTime.now().millisecondsSinceEpoch}.png';
    final Reference ref = _storage.ref().child(fileName);

    try {
      await ref.putFile(File(image.value!.path));
      final newUrl = await ref.getDownloadURL();
      // ถ้าอัปโหลดสำเร็จแล้ว ค่อยลบรูปเก่า (ถ้ามี และเป็น URL ของ Firebase Storage)

      // ignore: unnecessary_null_comparison
      if (oldImageUrl != null &&
          oldImageUrl.isNotEmpty &&
          oldImageUrl != newUrl &&
          oldImageUrl.contains('firebase')) {
        try {
          final oldRef = _storage.refFromURL(oldImageUrl);
          await oldRef.delete();
          log("ลบรูปเก่าเรียบร้อยแล้ว");
        } catch (e) {
          log("เกิดข้อผิดพลาดในการลบรูปเก่า: $e");
        }
      }

      urlNetwork.value = newUrl;
    } catch (e) {
      log("Error uploading image: $e");
    }
  }
}
