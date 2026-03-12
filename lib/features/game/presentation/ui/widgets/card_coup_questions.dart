import 'package:flutter/material.dart';

class CardCoupQuestions extends StatelessWidget {
  final String text;

  const CardCoupQuestions({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    const myStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: const Color(0xFF600010),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          children: [
            const Text(
              "Вопрос",
              style: myStyle1,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: myStyle,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
