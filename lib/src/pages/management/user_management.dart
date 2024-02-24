import 'package:app_test/core/route.dart';

class userManagementPage extends StatefulWidget {
  const userManagementPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<userManagementPage> createState() => _userManagementState();
}

class _userManagementState extends State<userManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Este apartado corresponde al usuario',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
