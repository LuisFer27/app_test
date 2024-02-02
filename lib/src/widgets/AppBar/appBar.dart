import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onLogout;

  MyAppBar({required this.title, required this.onLogout});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: onLogout,
        ),
      ],
    );
  }
}
