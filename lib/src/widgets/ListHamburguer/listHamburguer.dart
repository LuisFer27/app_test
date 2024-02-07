import 'package:flutter/material.dart';

class HamburguerList extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  HamburguerList({required this.text, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 200) {
              // Ajusta este valor según tus necesidades
              return Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Icon(icon, size: 32),
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(icon, size: 32),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
