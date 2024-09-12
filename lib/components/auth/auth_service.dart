import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instance from Auth service
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance from Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //login method

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //login method
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } //catch error
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //register method

  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password, String name, String position) async {
    try {
      //login method
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'name': name,
        'position': position,
        //pushed img by the default
        'profile_image':
            'https://cdn-icons-png.flaticon.com/512/9187/9187604.png',
      });
      return userCredential;
    } //catch error
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> logOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
