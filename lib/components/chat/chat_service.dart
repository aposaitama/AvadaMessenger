import 'package:avada_messenger/components/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatService extends ChangeNotifier {
  //instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //send message

  Future<void> sendMessage(String message) async {
    //get info about sender
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    DocumentSnapshot userDoc =
        await _firebaseFirestore.collection('users').doc(currentUserId).get();
    final String userName = userDoc.get('name');
    final String userPosition = userDoc.get('position');
    final Timestamp timestamp = Timestamp.now();

    //create new message

    Message newMessage = Message(
      senderId: currentUserId,
      senderName: userName,
      senderPosition: userPosition,
      message: message,
      timestamp: timestamp,
    );

    //add messege to database
    await _firebaseFirestore.collection('chat_room').add(newMessage.toMap());
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNamePosition() {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return _firebaseFirestore
        .collection('users')
        .doc(currentUserId)
        .snapshots();
  }

  //get messages
  Stream<QuerySnapshot> getMessages() {
    return _firebaseFirestore
        .collection('chat_room')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  String formatTimestamp(Timestamp timestamp) {
    //firestore timestamo to Date
    DateTime dateTime = timestamp.toDate();
    //add 3hrs
    DateTime adjustedDateTime = dateTime.add(const Duration(hours: 3));
    //return hrs+min
    return DateFormat('jm', 'en_US').format(adjustedDateTime);
  }
}
