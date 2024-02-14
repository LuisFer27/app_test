import 'package:app_test/core/route.dart';

class Btns extends StatelessWidget {
  const Btns({super.key, required this.menuText, required this.onTap});
  final String menuText;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
      child: Text(
        menuText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
