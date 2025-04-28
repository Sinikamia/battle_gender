import 'package:flutter/material.dart';

class CardWinner extends StatelessWidget {
  final String text;
  final String points;
  final String position;
  const CardWinner(
      {super.key,
      required this.text,
      required this.points,
      required this.position});

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Colors.black26,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Text(position, style: myStyle),
                const SizedBox(width: 10.0),
                Text(text, style: myStyle),
                const SizedBox(width: 10.0),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(points, style: myStyle),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
