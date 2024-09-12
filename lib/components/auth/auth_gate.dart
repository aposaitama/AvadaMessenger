import 'package:avada_messenger/components/auth/LoginOrRegister.dart';
import 'package:avada_messenger/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //if user is login
            if (snapshot.hasData) {
              return const HomePage();
            }

            //if user is not login
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
