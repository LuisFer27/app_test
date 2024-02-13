import 'package:app_test/core/libraries.dart';

class DashPageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Selecciona una opción del menú',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
