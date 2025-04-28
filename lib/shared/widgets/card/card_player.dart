import 'package:flutter/material.dart';

class CardPlayer extends StatelessWidget {
  final String text;
  final int points;
  const CardPlayer({
    super.key,
    required this.text,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const myStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );

    const myStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: width,
          color: Color(0xFF600010),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    text,
                    style: myStyle1,
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        "Твой результат:",
                        style: myStyle,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "$points/20 баллов",
                              style: myStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
