import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderName;
  final String senderPosition;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderName,
    required this.senderPosition,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderID": senderId,
      "senderName": senderName,
      "senderPosition": senderPosition,
      "message": message,
      "timestamp": timestamp
    };
  }
}
