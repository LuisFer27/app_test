import 'package:app_test/core/libraries.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function() onLogout;

  MyAppBar({required this.title, required this.onLogout});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      automaticallyImplyLeading:
          !isTablet, // No mostrar el botón de retroceso en modo tablet
      actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: onLogout,
        ),
      ],
    );
  }
}
