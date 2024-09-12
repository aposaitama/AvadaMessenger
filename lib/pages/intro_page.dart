import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});
  static const introColor = Color.fromRGBO(89, 177, 137, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo animation
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('lib/assets/animations/intro_animation.json'),
            ),
            //text under logo
            const Text(
              'Avada Messenger',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: introColor),
            ),
            const SizedBox(
              height: 20,
            ),
            //arrow button to navigate LoginPage
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/auth_gate'),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: introColor, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.arrow_right_alt,
                  size: 50,
                  color: introColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
