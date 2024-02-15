import 'package:app_test/core/route.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.title, required this.userId})
      : super(key: key);

  final String title;
  final int userId;

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController secondLastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? _image; // Variable para almacenar la imagen seleccionada
  String? _imagePath; // Ruta de la imagen seleccionada
  final Validations validations = Validations(); // Instancia de Validations

  @override
  void initState() {
    super.initState();
    // Cargar los datos del usuario al iniciar la página
    loadUserData();
  }

  Future<void> loadUserData() async {
    final dbUsers = DBUsers();
    final user = await dbUsers.getUserById(widget.userId);

    if (user != null) {
      setState(() {
        nameController.text = user['nombre'] ?? '';
        lastNameController.text = user['primer_apellido'] ?? '';
        secondLastNameController.text = user['segundo_apellido'] ?? '';
        userNameController.text = user['nombre_usuario'] ?? '';
        emailController.text = user['email'] ?? '';
        passwordController.text = user['contrasena'] ?? '';
        // Cargar la foto de perfil del usuario si está disponible
        _imagePath = user['image'] ?? '';
        if (_imagePath != null && _imagePath!.isNotEmpty) {
          _image = File(_imagePath!);
        }
      });
    }
  }

  Future<void> updateUserData() async {
    final dbUsers = DBUsers();

    // Obtén el ID del usuario para la actualización
    final user = await dbUsers.getUserById(widget.userId);
    final userId = user != null ? user['id'] : null;

    // Actualiza los datos en la base de datos
    await dbUsers.updateUser(
      userId,
      nameController.text,
      lastNameController.text,
      secondLastNameController.text,
      userNameController.text,
      emailController.text,
      passwordController.text,
      _imagePath, // Pasa la ruta de la imagen
    );

    // Muestra el mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Se han modificado los datos con éxito'),
      ),
    );
  }

  // Método para seleccionar una nueva foto de perfil
  Future<void> _selectNewProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final directory = await getApplicationDocumentsDirectory();
      final fileName =
          pickedFile.path.split('/').last; // Obtener el nombre del archivo
      final imagePath =
          '${directory.path}/$fileName'; // Utilizar el nombre original

      // Guarda la imagen en el directorio permanente
      await imageFile.copy(imagePath);
      print('Imagen guardada en: $imagePath');

      setState(() {
        _image = imageFile;
        _imagePath = imagePath;
      });

      // Actualiza la ruta de la imagen en la base de datos
      await updateUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _selectNewProfileImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: _image != null
                            ? Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/PNG/user.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextInput(
                  controller: nameController,
                  labelText: 'Nombre',
                  validator: (value) {
                    return validations.validateField(value ?? '', 50);
                  },
                ),
                TextInput(
                  controller: lastNameController,
                  labelText: 'Primer apellido',
                  validator: (value) {
                    return validations.validateField(value ?? '', 20);
                  },
                ),
                TextInput(
                  controller: secondLastNameController,
                  labelText: 'Segundo apellido',
                  validator: (value) {
                    validations.validateFieldNoRequired(value ?? '', 20);
                    return null;
                  },
                ),
                TextInput(
                  controller: userNameController,
                  labelText: 'Nombre de usuario',
                  validator: (value) {
                    return validations.validateUsername(value ?? '');
                  },
                ),
                TextInput(
                  controller: emailController,
                  labelText: 'Correo electrónico',
                  readOnly: true,
                  validator: (value) {
                    return validations.validateEmail(value ?? '');
                  },
                ),
                PasswordInput(
                  controller: passwordController,
                  labelText: 'Contraseña',
                  validator: (value) {
                    return validations.validatePassword(value ?? '');
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await updateUserData();
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
