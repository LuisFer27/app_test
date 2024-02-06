import 'package:flutter/material.dart';

class HamburguerList extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  HamburguerList({required this.text, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    // Obtén el ancho actual del Drawer
    double menuWidth = MediaQuery.of(context).size.width * 0.2;

    return ListTile(
      title: menuWidth > 200 // Ajusta el umbral según tus necesidades
          ? Text(
              text,
              style: TextStyle(fontSize: 16),
            )
          : null,
      leading: Container(
        alignment: Alignment.center,
        width: 56.0, // Ancho del contenedor para centrar el icono
        child: Icon(icon, size: 32),
      ),
      onTap: onTap,
    );
  }
}
