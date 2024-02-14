import 'package:app_test/core/route.dart';

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
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Icon(icon, size: 32),
              );
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(icon, size: 32),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 16),
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
