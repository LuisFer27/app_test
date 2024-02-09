import 'package:app_test/src/pages/barcodeqr/barcode_qr.dart';
import 'package:app_test/src/pages/list/categories.dart';
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
  String? appBarTitle;
  Widget? currentPage;
  double menuWidthPercentage = 0.2; // Porcentaje inicial del ancho del menú

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
      body: Row(
        children: [
          Expanded(
            flex: (menuWidthPercentage * 100).toInt(),
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  menuWidthPercentage +=
                      details.primaryDelta! / context.size!.width;
                  menuWidthPercentage = menuWidthPercentage.clamp(0.1, 0.9);
                });
              },
              child: Drawer(
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
                          'Editar perfil',
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
                      text: 'Escanear QR y barcode',
                      onTap: () {
                        _updateCurrentPage(
                            QrBarcodePage(title: 'Escanear QR y barcode'),
                            'Escanear QR y barcode');
                      },
                      icon: Icons.qr_code,
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
                      text: 'Lista de ejemplo',
                      onTap: () {
                        _updateCurrentPage(ListPage(title: 'Lista de ejemplo'),
                            'Lista de ejemplo');
                      },
                      icon: Icons.list,
                    ),
                    HamburguerList(
                      text: 'Lista de categorias',
                      onTap: () {
                        _updateCurrentPage(
                            ListCategoriesPage(title: 'Lista de categorias'),
                            'Lista de categorias');
                      },
                      icon: Icons.list,
                    ),
                    HamburguerList(
                      text: 'Ver ubicación',
                      onTap: () {
                        _updateCurrentPage(
                            GeolocatorPage(title: 'Ver ubicación'),
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
            ),
          ),
          VerticalDivider(
            width: 1,
          ),
          Expanded(
            flex: 100 - (menuWidthPercentage * 100).toInt(),
            child: Scaffold(
              appBar: MyAppBar(
                title: appBarTitle ?? '',
                onLogout: () => LogoutController.logout(
                  context,
                  setState,
                  userNameController,
                  userEmail,
                  userFullName,
                  currentPage,
                ),
              ),
              body: currentPage ?? DashPageState(),
            ),
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
              text: 'Escanear QR y barcode',
              onTap: () {
                _updateCurrentPage(
                    QrBarcodePage(title: 'Escanear QR y barcode'),
                    'Escanear QR y barcode');
                Navigator.pop(context);
              },
              icon: Icons.qr_code,
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
              text: 'Lista de ejemplo',
              onTap: () {
                _updateCurrentPage(
                    ListPage(title: 'Lista de ejemplo'), 'Lista de ejemplo');
                Navigator.pop(context);
              },
              icon: Icons.list,
            ),
            HamburguerList(
              text: 'Lista de categorias',
              onTap: () {
                _updateCurrentPage(
                    ListCategoriesPage(title: 'Lista de categorias'),
                    'Lista de categorias');
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
