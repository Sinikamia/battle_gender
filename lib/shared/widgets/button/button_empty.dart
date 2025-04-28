import 'package:flutter/material.dart';

class ButtonEmpty extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final IconData icon;
  const ButtonEmpty({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    const myStyle = TextStyle(
      color: Color(0xFF600010),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
    return Container(
      width: width,
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF600010), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(icon, color: Color(0xFF600010)),
                const SizedBox(width: 5),
                Expanded(child: Center(child: Text(text, style: myStyle))),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
