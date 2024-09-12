import 'package:avada_messenger/components/auth/auth_service.dart';
import 'package:avada_messenger/components/gesture_detector.dart';
import 'package:avada_messenger/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final positionController = TextEditingController();

  //register user
  void register() async {
    //auth services
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          emailController.text,
          passwordController.text,
          nameController.text,
          positionController.text);
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //name textfield
              MyTextField(
                text: 'Your Name',
                controller: nameController,
              ),

              const SizedBox(
                height: 15,
              ),
              //position textfied

              MyTextField(
                text: 'Your Position',
                controller: positionController,
              ),

              const SizedBox(
                height: 15,
              ),
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
              //register button
              MyGestureDetector(onTap: register, text: 'Register'),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  'Already have an account? Login',
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
