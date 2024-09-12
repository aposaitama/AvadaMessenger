import 'package:avada_messenger/components/home_page/user_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:avada_messenger/components/chat/chat_service.dart';

class MessageItem extends StatelessWidget {
  final DocumentSnapshot document;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();
  final UserService _userService = UserService();

  MessageItem({required this.document});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _firebaseAuth.currentUser!.uid;

    var backgroundColor = isCurrentUser ? Colors.blue : Colors.grey[200];
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser) _buildLogo(data['senderID']),
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            constraints: const BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft:
                    isCurrentUser ? const Radius.circular(12) : Radius.zero,
                bottomRight:
                    isCurrentUser ? Radius.zero : const Radius.circular(12),
              ),
            ),
            child: _buildMessageContent(data, isCurrentUser),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent(Map<String, dynamic> data, bool isCurrentUser) {
    return isCurrentUser
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data['message'],
                maxLines: null,
                overflow: TextOverflow.visible,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                _chatService.formatTimestamp(data['timestamp']),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(data['senderName'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                  Text(data['senderPosition'],
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 4),
              Text(data['message'],
                  style: const TextStyle(color: Colors.black)),
              const SizedBox(height: 4),
              Text(_chatService.formatTimestamp(data['timestamp']),
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          );
  }

  Widget _buildLogo(String userId) {
    return FutureBuilder<String>(
      future: _userService.getProfileImageUrl(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/9187/9187604.png'),
            radius: 20,
          );
        }
        return CircleAvatar(
          backgroundImage: NetworkImage(snapshot.data!),
          radius: 20,
        );
      },
    );
  }
}
