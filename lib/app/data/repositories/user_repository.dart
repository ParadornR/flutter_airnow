import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_airnow/app/data/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Function to fetch user data
  Future<User?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await _firebaseFirestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return User.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null; // No user found
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return null;
    }
  }
}
