import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  MessageInput({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      //message input widget
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.grey))),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Expanded(
              child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: 'Start typing...', border: InputBorder.none),
          )),
          IconButton(onPressed: onSend, icon: const Icon(Icons.send)),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
