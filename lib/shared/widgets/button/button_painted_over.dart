import 'package:flutter/material.dart';

class ButtonPaintedOver extends StatelessWidget {
  final String text;
  final Function() onTap;

  const ButtonPaintedOver({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    const myStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF600010),
          ),
          onPressed: onTap,
          child: Text(text, style: myStyle1),
        ),
      ),
    );
  }
}
