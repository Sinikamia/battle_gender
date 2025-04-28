import 'package:flutter/material.dart';

class AppBarUniversal extends StatelessWidget implements PreferredSizeWidget {
  final Function()? onTap;
  final String text;
  final IconData? iconMenu;
  final IconData? iconSettings;
  final Function()? onTapMenu;
  final Function()? onTapSettings;
  const AppBarUniversal({
    super.key,
    this.onTap,
    this.iconMenu,
    this.iconSettings,
    this.onTapMenu,
    this.onTapSettings,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    const myStyle = TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF600010), //Color(0xFF40020E),
      elevation: 10,
      leading: onTap != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white),
              onPressed: onTap,
            )
          : null,
      title: Text(text, style: myStyle),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(iconMenu, color: Colors.white),
          onPressed: onTapMenu,
        ),
        IconButton(
          icon: Icon(iconSettings, color: Colors.white),
          onPressed: onTapSettings,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
