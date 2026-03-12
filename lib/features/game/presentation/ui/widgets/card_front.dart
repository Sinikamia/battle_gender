import 'package:flutter/material.dart';

class CardFront extends StatelessWidget {
  const CardFront({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 0.8,
      duration: const Duration(seconds: 2),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage('assets/battle_gender_1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
