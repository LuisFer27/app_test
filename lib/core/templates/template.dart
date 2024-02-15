import 'package:app_test/core/route.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.userId, // Cambiado de userNameController a userId
  }) : super(key: key);

  final String title;
  final int userId; // Cambiado de String a int?

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? userId;
  String? userEmail;
  String? userName;
  String? userFullName;
  String? appBarTitle;
  Widget? currentPage;
  double menuWidthPercentage = 0.2;
  File? _image; // Agrega una variable de estado para la imagen seleccionada

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final dbUsers = DBUsers();
    final userId = widget.userId;
    final user = await dbUsers.getUserById(userId);
    if (user != null) {
      setState(() {
        this.userId = userId;
        userName = user['nombre_usuario']; // Aquí cargamos el nombre de usuario
        userEmail = user['email'];
        userFullName =
            '${user['nombre']} ${user['primer_apellido']} ${user['segundo_apellido']}';
        // Cargar la imagen del usuario
        //_loadUserProfileImage(user['id']); // Asume que 'id' es el ID del usuario
      });
    }
  }

  //Future<void> _loadUserProfileImage(int userId) async {
  //  final userDirectory = await getApplicationDocumentsDirectory();
  //  final userAssetsDir = '${userDirectory.path}/user_$userId';
  //  final imageFileName =
  //      'profile_image.jpg'; // Nombre de archivo para la imagen de perfil
  //  final imageFile = File('$userAssetsDir/$imageFileName');
  //  if (imageFile.existsSync()) {
  //    setState(() {
  //      _image = imageFile;
  //    });
  //  }
  //}

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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navegar a la página Dash al presionar el botón de atrás
                    _updateCurrentPage(DashPageState(), 'Dash');
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () => LogoutController.logout(
                      context,
                      setState,
                      userId, // Cambiado de userId a String
                      userEmail,
                      userFullName,
                      userName,
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
              userId, // Cambiado de userId a String
              userEmail,
              userFullName,
              userName,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              // Mostrar la imagen de perfil del usuario o una imagen de placeholder
              backgroundImage: _image != null
                  ? FileImage(_image!) // Si hay una imagen, mostrarla
                  : AssetImage('assets/images/PNG/user.png') as ImageProvider<
                      Object>, // Convertir a ImageProvider<Object>
            ),
            const SizedBox(
                height: 8), // Espacio entre la imagen de perfil y el texto
            Text(
              userName ?? 'Usuario',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      HamburguerList(
        text: 'Editar perfil',
        onTap: () => _updateCurrentPage(
          EditProfilePage(
            title: 'Editar perfil',
            userId: userId ?? 0,
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
          userId,
          userEmail,
          userFullName,
          userName,
          currentPage,
        ),
        icon: Icons.logout,
      ), // Resto de elementos del menú...
    ];
  }

  void _updateCurrentPage(Widget page, String newTitle) {
    setState(() {
      currentPage = page;
      appBarTitle = newTitle;
    });
  }
}
