import 'package:app_test/model/db_users.dart';
import 'package:flutter/material.dart';
import 'package:app_test/src/widgets/PasswordField/passwordField.dart';
import 'package:app_test/src/widgets/TextField/textField.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';

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

    // Inicializa el controlador de nombre de usuario con el valor pasado
    userNameController.text = widget.userName;

    // Carga los datos del usuario al iniciar la página
    loadUserData();
  }

  Future<void> loadUserData() async {
    final dbUsers = DBUsers.instance;
    final user = await dbUsers.getUserByUsername(userNameController.text);

    if (user != null) {
      setState(() {
        nameController.text = user['nombre'] ?? '';
        lastNameController.text = user['primer_apellido'] ?? '';
        secondLastNameController.text = user['segundo_apellido'] ?? '';
        emailController.text = user['email'] ?? '';
        passwordController.text = user['contrasena'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(
          child: Text(
            'Registro de usuario',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Btns(
                  menuText: 'Guardar',
                  onTap: () async {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
