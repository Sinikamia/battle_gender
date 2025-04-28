import 'package:flutter/material.dart';

class CardCreationPlayer extends StatelessWidget {
  final TextEditingController controller;
  final Function() onPressed;
  final Function() onTap;
  final Function() onTap2;
  final int selectedIndex;
  const CardCreationPlayer({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.onTap,
    required this.onTap2,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: width,
          height: 50,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF40020E),
                //Color(0xFF7B1E1E),
                Color(0xFF9A031E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.highlight_remove, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  maxLength: 12,
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Добавить имя",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white70),
                    counterText: "",
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 60),
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  Icons.man_sharp,
                  color: selectedIndex == 0 ? Colors.white : Colors.black45,
                ),
              ),
              IconButton(
                onPressed: onTap2,
                icon: Icon(
                  Icons.woman_sharp,
                  color: selectedIndex == 1 ? Colors.white : Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
