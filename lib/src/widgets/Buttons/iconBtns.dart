import 'package:app_test/core/route.dart';

class IconBtns extends StatelessWidget {
  const IconBtns(
      {super.key, required this.icon, this.color, required this.onTap});
  final IconData icon;

  final Color? color;

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
