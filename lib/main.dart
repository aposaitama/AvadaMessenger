import 'package:avada_messenger/components/auth/auth_gate.dart';
import 'package:avada_messenger/components/auth/auth_service.dart';
import 'package:avada_messenger/pages/change_data.dart';
import 'package:avada_messenger/pages/chat_page.dart';
import 'package:avada_messenger/pages/intro_page.dart';
import 'package:avada_messenger/pages/login_page.dart';
import 'package:avada_messenger/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/register_page': (context) => const RegisterPage(),
        '/chat_page': (context) => const ChatPage(),
        '/auth_gate': (context) => const AuthGate(),
        '/change_data': (context) => const ChangeUserData()
      },
      home: const IntroPage(),
    );
  }
}
