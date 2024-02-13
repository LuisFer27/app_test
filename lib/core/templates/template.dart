import 'package:flutter/material.dart';
import 'package:app_test/core/widgets.dart';
import 'package:app_test/core/libraries.dart';
import 'package:app_test/core/controllers.dart';
import 'package:app_test/model/db_users.dart';
import 'package:app_test/core/pages.dart';

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
  double menuWidthPercentage = 0.2;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final dbUsers = DBUsers();
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
          return _buildTabletLayout();
        } else {
          return _buildPhoneLayout(
              context); // Pasar el contexto al método _buildPhoneLayout
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
                  children: _buildDrawerItems(),
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
              appBar: AppBar(
                title: Text(appBarTitle ?? ''),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                actions: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () => LogoutController.logout(
                      context,
                      setState,
                      userNameController,
                      userEmail,
                      userFullName,
                      currentPage,
                    ),
                  ),
                ],
              ),
              body: currentPage ?? DashPageState(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneLayout(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(appBarTitle ?? ''),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => LogoutController.logout(
              context,
              setState,
              userNameController,
              userEmail,
              userFullName,
              currentPage,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildDrawerItems(),
        ),
      ),
      body: currentPage ?? DashPageState(),
    );
  }

  List<Widget> _buildDrawerItems() {
    return [
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
        onTap: () => _updateCurrentPage(
          EditProfilePage(
            title: 'Editar perfil',
            userName: userNameController ?? "",
          ),
          'Editar perfil',
        ),
        icon: Icons.edit,
      ),
      HamburguerList(
        text: 'Grabar audio',
        onTap: () => _updateCurrentPage(
          RecordPage(title: 'Grabar audio'),
          'Grabar audio',
        ),
        icon: Icons.mic,
      ),
      HamburguerList(
        text: 'Tomar foto',
        onTap: () => _updateCurrentPage(
          PhotoScreen(title: 'Tomar foto'),
          'Tomar foto',
        ),
        icon: Icons.camera,
      ),
      HamburguerList(
        text: 'Escanear QR y barcode',
        onTap: () => _updateCurrentPage(
          QrBarcodePage(title: 'Escanear QR y barcode'),
          'Escanear QR y barcode',
        ),
        icon: Icons.qr_code,
      ),
      HamburguerList(
        text: 'Tomar video',
        onTap: () => _updateCurrentPage(
          VideoRecord(title: 'Tomar video'),
          'Tomar video',
        ),
        icon: Icons.video_camera_back,
      ),
      HamburguerList(
        text: 'Lista de ejemplo',
        onTap: () => _updateCurrentPage(
          ListPage(title: 'Lista de ejemplo'),
          'Lista de ejemplo',
        ),
        icon: Icons.list,
      ),
      HamburguerList(
        text: 'Lista de categorías',
        onTap: () => _updateCurrentPage(
          ListCategoriesPage(title: 'Lista de categorías'),
          'Lista de categorías',
        ),
        icon: Icons.list,
      ),
      HamburguerList(
        text: 'Lista de productos',
        onTap: () => _updateCurrentPage(
          ListProductsPage(title: 'Lista de productos'),
          'Lista de productos',
        ),
        icon: Icons.shopping_bag,
      ),
      HamburguerList(
        text: 'Ver ubicación',
        onTap: () => _updateCurrentPage(
          GeolocatorPage(title: 'Ver ubicación'),
          'Ver ubicación',
        ),
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
    ];
  }

  void _updateCurrentPage(Widget page, String newTitle) {
    setState(() {
      currentPage = page;
      appBarTitle = newTitle;
    });
  }
}
