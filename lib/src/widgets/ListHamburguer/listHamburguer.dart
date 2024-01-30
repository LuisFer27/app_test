import 'package:flutter/material.dart';

class HamburguerList extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const HamburguerList({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ));
  }
}
