import 'package:flutter/material.dart';

class IconBtns extends StatelessWidget {
  const IconBtns(
      {super.key,
      required this.icon,
      required this.color,
      required this.onTap});
  final IconData icon;

  final Color color;

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      onPressed: onTap,
    );
  }
}
