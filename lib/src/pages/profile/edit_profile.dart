import 'package:flutter/material.dart';
import 'package:app_test/src/widgets/PasswordField/passwordField.dart';
import 'package:app_test/src/widgets/TextField/textField.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.title});
  final String title;
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
