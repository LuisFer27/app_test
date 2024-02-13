import 'package:app_test/core/libraries.dart';
import 'package:app_test/model/db_users.dart';
import 'package:app_test/core/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                Btns(
                  menuText: 'Guardar',
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Validación exitosa, actualiza los datos del usuario
                      await updateUserData();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
