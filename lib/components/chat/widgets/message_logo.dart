import 'package:avada_messenger/components/home_page/user_service.dart';
import 'package:flutter/material.dart';

class MessageLogo extends StatelessWidget {
  final String userId;
  MessageLogo({super.key, required this.userId});
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      //widget for logo that locate left to msg
      future: _userService.getProfileImageUrl(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          );
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
