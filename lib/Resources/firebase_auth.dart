import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/Storage_methods.dart';

class AuthMethods {
  //a firebase auth instance to accesss the firebase methods
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign_up function
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty ||
              password.isEmpty ||
              username.isNotEmpty ||
              bio.isNotEmpty
          // file != null
          ) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user?.email);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profile Pics', file, false);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl
        });
      }
      res = "success";
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "email is badly formatted";
      } else if (err.code == 'weak-password') {
        res = 'your password must be 6 characters or more';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //firebaseloginmethods
  Future<String> logInUser(
      {required String email, required String password}) async {
    String res = 'something went wrong';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = "please enter email and password";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
