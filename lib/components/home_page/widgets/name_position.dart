import 'package:avada_messenger/components/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NameAndPosition extends StatelessWidget {
  NameAndPosition({super.key});
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    //wgt for getting position info
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _chatService.getNamePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const Text('No data');
        }

        var userData = snapshot.data!.data();
        String name = userData?['name'] ?? 'Unknown Name';
        String position = userData?['position'] ?? 'Unknown Position';

        return Center(
          child: Text(
            '$name $position',
            style: const TextStyle(
                fontSize: 24, decoration: TextDecoration.underline),
          ),
        );
      },
    );
  }
}
