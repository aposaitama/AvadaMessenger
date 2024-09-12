import 'package:avada_messenger/components/auth/auth_service.dart';
import 'package:avada_messenger/components/gesture_detector.dart';
import 'package:avada_messenger/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    //auth services
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //email textfield
              MyTextField(
                text: 'Email',
                controller: emailController,
              ),

              const SizedBox(
                height: 15,
              ),
              //password textfield
              MyTextField(
                text: 'Password',
                controller: passwordController,
              ),

              const SizedBox(
                height: 15,
              ),
              //login button
              MyGestureDetector(onTap: login, text: 'Login'),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              )

              //register button
            ],
          ),
        ),
      ),
    );
  }
}
