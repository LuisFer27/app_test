import 'package:app_test/model/db_users.dart';
import 'package:app_test/src/widgets/ListHamburguer/listHamburguer.dart';
import 'package:flutter/material.dart';
import 'package:app_test/src/pages/record/record.dart';
import 'package:app_test/src/pages/imagepicker/photo_screen.dart';
import 'package:app_test/src/pages/video/video_record.dart';
import 'package:app_test/src/pages/list/list.dart';
import 'package:app_test/src/pages/geolocalization/geolocalization.dart';
import 'package:app_test/src/pages/profile/edit_profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userNameController;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final db = DBUsers.instance;
    final user = await db.getUserByEmail('email');

    if (user != null) {
      setState(() {
        userNameController = user['nombre_usuario'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text(
                'Hola, ${userNameController ?? 'Usuario'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            HamburguerList(
              text: 'Editar perfil',
              onTap: () {
                _navigateToPage(
                    context, EditProfilePage(title: 'Editar perfil'));
              },
            ),
            HamburguerList(
              text: 'Grabar audio',
              onTap: () {
                _navigateToPage(context, RecordPage(title: 'Grabar audio'));
              },
            ),
            HamburguerList(
              text: 'Tomar foto',
              onTap: () {
                _navigateToPage(context, PhotoScreen(title: 'Tomar foto'));
              },
            ),
            HamburguerList(
              text: 'Tomar video',
              onTap: () {
                _navigateToPage(context, VideoRecord(title: 'Tomar video'));
              },
            ),
            HamburguerList(
              text: 'Ver lista',
              onTap: () {
                _navigateToPage(context, ListPage(title: 'Ver lista'));
              },
            ),
            HamburguerList(
              text: 'Ver ubicación',
              onTap: () {
                _navigateToPage(
                    context, GeolocatorPage(title: 'Ver ubicación'));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
