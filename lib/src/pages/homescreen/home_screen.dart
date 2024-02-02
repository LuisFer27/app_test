import 'package:flutter/material.dart';
import 'package:app_test/src/controllers/logout_controller.dart';
import 'package:app_test/src/widgets/AppBar/appBar.dart';
import 'package:app_test/model/db_users.dart';
import 'package:app_test/src/widgets/ListHamburguer/listHamburguer.dart';
import 'package:app_test/src/pages/record/record.dart';
import 'package:app_test/src/pages/imagepicker/photo_screen.dart';
import 'package:app_test/src/pages/video/video_record.dart';
import 'package:app_test/src/pages/list/list.dart';
import 'package:app_test/src/pages/geolocalization/geolocalization.dart';
import 'package:app_test/src/pages/profile/edit_profile.dart';
import 'package:app_test/src/pages/dash/dash.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.userNameController,
  }) : super(key: key);

  final String title;
  final String userNameController;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userNameController;
  String? userEmail;
  String? userFullName;
  String? appBarTitle; // Nuevo: variable para almacenar el título del AppBar
  Widget? currentPage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // Establece la página inicial
  }

  Future<void> _loadUserData() async {
    final dbUsers = DBUsers.instance;

    final username = widget.userNameController;

    final user = await dbUsers.getUserByUsername(username);

    if (user != null) {
      setState(() {
        userNameController = user['nombre_usuario'];
        userEmail = user['email'];
        userFullName =
            '${user['nombre']} ${user['primer_apellido']} ${user['segundo_apellido']}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet layout
          return _buildTabletLayout();
        } else {
          // Phone layout
          return _buildPhoneLayout();
        }
      },
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      appBar: MyAppBar(
        title: appBarTitle ?? '', // Usa una cadena vacía si appBarTitle es nulo
        onLogout: () => LogoutController.logout(
          context,
          setState,
          userNameController,
          userEmail,
          userFullName,
          currentPage,
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
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
                    _updateCurrentPage(
                      EditProfilePage(
                        title: 'Editar perfil',
                        userName: userNameController ?? "",
                      ),
                      'Editar perfil', // Nuevo: establece el nuevo título
                    );
                  },
                  icon: Icons.edit,
                ),
                HamburguerList(
                  text: 'Grabar audio',
                  onTap: () {
                    _updateCurrentPage(
                        RecordPage(title: 'Grabar audio'), 'Grabar audio');
                  },
                  icon: Icons.mic,
                ),
                HamburguerList(
                  text: 'Tomar foto',
                  onTap: () {
                    _updateCurrentPage(
                        PhotoScreen(title: 'Tomar foto'), 'Tomar foto');
                  },
                  icon: Icons.camera,
                ),
                HamburguerList(
                  text: 'Tomar video',
                  onTap: () {
                    _updateCurrentPage(
                        VideoRecord(title: 'Tomar video'), 'Tomar video');
                  },
                  icon: Icons.video_camera_back,
                ),
                HamburguerList(
                  text: 'Ver lista',
                  onTap: () {
                    _updateCurrentPage(
                        ListPage(title: 'Ver lista'), 'Ver lista');
                  },
                  icon: Icons.list,
                ),
                HamburguerList(
                  text: 'Ver ubicación',
                  onTap: () {
                    _updateCurrentPage(GeolocatorPage(title: 'Ver ubicación'),
                        'Ver ubicación');
                  },
                  icon: Icons.location_on,
                ),
                HamburguerList(
                  text: 'Cerrar sesión',
                  onTap: () => LogoutController.logout(
                    context,
                    setState,
                    userNameController,
                    userEmail,
                    userFullName,
                    currentPage,
                  ),
                  icon: Icons.logout,
                ),
              ],
            ),
          ),
          VerticalDivider(
            width: 1,
          ),
          Expanded(
            flex: 3,
            child: currentPage ?? DashPageState(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Scaffold(
      appBar: MyAppBar(
        title: appBarTitle ?? '', // Usa una cadena vacía si appBarTitle es nulo
        onLogout: () => LogoutController.logout(
          context,
          setState,
          userNameController,
          userEmail,
          userFullName,
          currentPage,
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
                _updateCurrentPage(
                  EditProfilePage(
                    title: 'Editar perfil',
                    userName: userNameController ?? "",
                  ),
                  'Editar perfil', // Nuevo: establece el nuevo título
                );
                Navigator.pop(
                    context); // Cierra el Drawer al seleccionar una opción
              },
              icon: Icons.edit,
            ),
            HamburguerList(
              text: 'Grabar audio',
              onTap: () {
                _updateCurrentPage(
                    RecordPage(title: 'Grabar audio'), 'Grabar audio');
                Navigator.pop(context);
              },
              icon: Icons.mic,
            ),
            HamburguerList(
              text: 'Tomar foto',
              onTap: () {
                _updateCurrentPage(
                    PhotoScreen(title: 'Tomar foto'), 'Tomar foto');
                Navigator.pop(context);
              },
              icon: Icons.camera,
            ),
            HamburguerList(
              text: 'Tomar video',
              onTap: () {
                _updateCurrentPage(
                    VideoRecord(title: 'Tomar video'), 'Tomar video');
                Navigator.pop(context);
              },
              icon: Icons.video_camera_back,
            ),
            HamburguerList(
              text: 'Ver lista',
              onTap: () {
                _updateCurrentPage(ListPage(title: 'Ver lista'), 'Ver lista');
                Navigator.pop(context);
              },
              icon: Icons.list,
            ),
            HamburguerList(
              text: 'Ver ubicación',
              onTap: () {
                _updateCurrentPage(
                    GeolocatorPage(title: 'Ver ubicación'), 'Ver ubicación');
                Navigator.pop(context);
              },
              icon: Icons.location_on,
            ),
            HamburguerList(
              text: 'Cerrar sesión',
              onTap: () => LogoutController.logout(
                context,
                setState,
                userNameController,
                userEmail,
                userFullName,
                currentPage,
              ),
              icon: Icons.logout,
            ),
          ],
        ),
      ),
      body: currentPage ?? DashPageState(),
    );
  }

  void _updateCurrentPage(Widget page, String newTitle) {
    setState(() {
      currentPage = page;
      appBarTitle = newTitle; // Nuevo: actualiza el título del AppBar
    });
  }
}
