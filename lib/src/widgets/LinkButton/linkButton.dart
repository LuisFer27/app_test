import 'package:app_test/core/route.dart';

class LinkButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const LinkButton({
    required this.onTap,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
