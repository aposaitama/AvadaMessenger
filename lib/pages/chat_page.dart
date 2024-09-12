import 'package:avada_messenger/components/chat/chat_service.dart';
import 'package:avada_messenger/components/chat/widgets/last_time_msg.dart';
import 'package:avada_messenger/components/chat/widgets/message_input.dart';
import 'package:avada_messenger/components/chat/widgets/message_list.dart';
import 'package:avada_messenger/components/chat/widgets/senders_logo.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SendersLogos(),
                  LastTimeMsg(),
                ],
              ),
            ),
          ),
          Expanded(
            child: MessageList(),
          ),
          MessageInput(controller: messageController, onSend: sendMessage)
        ],
      ),
    );
  }
}
