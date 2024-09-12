import 'package:avada_messenger/components/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LastTimeMsg extends StatelessWidget {
  LastTimeMsg({super.key});
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
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
        // Take the last message's timestamp or return an empty widget if no messages
        final lastMessageTimestamp =
            messages.isNotEmpty ? messages.last['timestamp'] : null;

        // Pass the timestamp to the widget that formats and displays it
        return lastMessageTimestamp != null
            ? _buildLastTimeMsg(lastMessageTimestamp)
            : const Text('No messages');
      },
    );
  }

  Widget _buildLastTimeMsg(Timestamp timestamp) {
    // Format the timestamp
    String formattedTime = _chatService.formatTimestamp(timestamp);

    // Display the formatted time
    return Text(
      'last seen at: $formattedTime',
      style: const TextStyle(fontSize: 14, color: Colors.grey),
    );
  }
}
