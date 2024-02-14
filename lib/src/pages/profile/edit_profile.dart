import 'package:app_test/core/route.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.title, required this.userName})
      : super(key: key);

  final String title;
  final String userName;

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

  @override
  void initState() {
    super.initState();
    // Cargar los datos del usuario al iniciar la página
    loadUserData();
  }

  Future<void> loadUserData() async {
    final dbUsers = DBUsers();
    final user = await dbUsers.getUserByUsername(widget.userName);

    if (user != null) {
      setState(() {
        nameController.text = user['nombre'] ?? '';
        lastNameController.text = user['primer_apellido'] ?? '';
        secondLastNameController.text = user['segundo_apellido'] ?? '';
        userNameController.text =
            user['nombre_usuario'] ?? ''; // Corregir el nombre del campo
        emailController.text = user['email'] ?? '';
        passwordController.text = user['contrasena'] ?? '';
        // Cargar la foto de perfil del usuario si está disponible
        // Esto dependerá de cómo estés almacenando las imágenes en tu base de datos
        // Aquí estamos suponiendo que tienes una ruta de la imagen almacenada en la base de datos
        // Puedes cargar la imagen usando la biblioteca de imágenes de Flutter o cualquier otra forma que prefieras
        // Por ahora, simplemente dejamos la lógica de cargar la imagen como una tarea pendiente
      });
    }
  }

  Future<void> updateUserData() async {
    final dbUsers = DBUsers();

    // Obtén el ID del usuario para la actualización
    final user = await dbUsers.getUserByUsername(widget.userName);
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
      setState(() {
        _image = File(pickedFile.path);
      });
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
                    // Mostrar la imagen de perfil actual o una imagen de placeholder si no hay ninguna
                    backgroundImage: _image != null
                        ? FileImage(
                            _image!) // Si hay una nueva imagen seleccionada, mostrarla
                        : AssetImage('assets/images/PNG/user.png')
                            as ImageProvider, // De lo contrario, mostrar una imagen de placeholder
                  ),
                ),
                SizedBox(height: 8),
                TextInput(
                  controller: nameController,
                  labelText: 'Nombre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce tu nombre';
                    }
                    return null;
                  },
                ),
                TextInput(
                  controller: lastNameController,
                  labelText: 'Primer apellido',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce tu apellido';
                    }
                    return null;
                  },
                ),
                TextInput(
                  controller: secondLastNameController,
                  labelText: 'Segundo apellido',
                ),
                TextInput(
                  controller: userNameController,
                  labelText: 'Nombre de usuario',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce un nombre de usuario';
                    }
                    return null;
                  },
                ),
                TextInput(
                  controller: emailController,
                  labelText: 'Correo electrónico',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce un correo electrónico';
                    }
                    return null;
                  },
                ),
                PasswordInput(
                  controller: passwordController,
                  labelText: 'Contraseña',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce una contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Validación exitosa, actualiza los datos del usuario
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
