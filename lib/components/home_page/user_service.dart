import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //getting profile img
  Future<String> getProfileImageUrl(String userID) async {
    //take snaphot of data
    DocumentSnapshot userDoc =
        await _firebaseFirestore.collection('users').doc(userID).get();
    //if user exist, return profile image, if don't, return network logo
    if (userDoc.exists) {
      return userDoc['profile_image'];
    } else {
      return 'https://cdn-icons-png.flaticon.com/512/9187/9187604.png';
    }
  }

//fet user data stream
  Stream<DocumentSnapshot> getUserDataStream() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return _firebaseFirestore.collection('users').doc(user.uid).snapshots();
    } else {
      throw Exception('No user is currently signed in.');
    }
  }

  //method for update userdata
  Future<void> updateUserData(String name, String position) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String uid = user.uid;

      try {
        await _firebaseFirestore.collection('users').doc(uid).update({
          'name': name,
          'position': position,
        });
      } catch (e) {
        throw Exception('Failed to update user data: $e');
      }
    } else {
      throw Exception('No user is currently signed in.');
    }
  }
}
