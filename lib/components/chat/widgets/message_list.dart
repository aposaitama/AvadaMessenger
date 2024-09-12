import 'package:avada_messenger/components/chat/chat_service.dart';
import 'package:avada_messenger/components/chat/widgets/message_logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  MessageList({super.key});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _chatService.getMessages(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          return ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList());
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
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
          if (!isCurrentUser) MessageLogo(userId: data['senderID']),
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
            child: !isCurrentUser
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: isCurrentUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Text(
                              data['senderName'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data['senderPosition'],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['message'],
                          maxLines: null,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        Text(_chatService.formatTimestamp(data['timestamp']),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Text(
                          data['message'],
                          maxLines: null,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _chatService.formatTimestamp(data['timestamp']),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
