import 'package:avada_messenger/components/chat/chat_service.dart';
import 'package:avada_messenger/components/home_page/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendersLogos extends StatelessWidget {
  SendersLogos({super.key});
  final ChatService _chatService = ChatService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    //wgt for showing last 5 msgs
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        final messages = snapshot.data!.docs;

        //if msgs <5, take all that we have
        final lastMessages = messages.length >= 5
            ? messages.sublist(messages.length - 5)
            : messages;

        return _buildSendersLogos(lastMessages);
      },
    );
  }

  Widget _buildSendersLogos(List<QueryDocumentSnapshot> lastMessages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: lastMessages.map((message) {
        String senderId = message['senderID'];

        return FutureBuilder<String>(
          future: _userService.getProfileImageUrl(senderId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.error),
              );
            }
            return CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data!),
              radius: 7,
            );
          },
        );
      }).toList(),
    );
  }
}
