import 'package:flutter/material.dart';

class HamburguerList extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData? icon; // Nuevo atributo para el icono

  const HamburguerList({
    required this.text,
    required this.onTap,
    this.icon, // Icono opcional
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          if (icon != null) // Agrega el icono si está definido
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                size: 24.0,
              ),
            ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
