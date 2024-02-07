import 'package:flutter/material.dart';
import 'package:app_test/src/pages/homescreen/home_screen.dart';
//import 'package:app_test/src/controllers/connection/data_base_controller.dart';
import 'package:app_test/src/pages/login/register.dart';
import 'package:app_test/src/widgets/PasswordField/passwordField.dart';
import 'package:app_test/src/widgets/TextField/textField.dart';
import 'package:app_test/src/widgets/Buttons/btns.dart';
import 'package:app_test/src/widgets/LinkButton/linkButton.dart';
import 'package:app_test/model/db_users.dart';
//import 'package:mysql1/mysql1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //MySqlConnection? _connection;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dbUsers = DBUsers.instance;

  @override
  void initState() {
    super.initState();
    //_connectToMySQL();
  }

  // Future<void> _connectToMySQL() async {
  //   try {
  //     _connection = await MySQLService.connectToMySQL();
  //   } catch (e) {
  //     // Manejar errores de conexión aquí
  //     print('Error de conexión: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(
          child: Text(
            'Iniciar sesión',
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
                  controller: emailController,
                  labelText: 'Correo electrónico',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce un correo electrónico válido';
                    }
                    return null;
                  },
                ),
                PasswordInput(
                  controller: passwordController,
                  labelText: 'Contraseña',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce tu contraseña';
                    }
                    return null;
                  },
                ),
                Btns(
                  menuText: 'Iniciar sesión',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // Consultar la base de datos para verificar el usuario
                      final user =
                          await dbUsers.getUserByEmail(emailController.text);
                      if (user != null &&
                          user['contrasena'] == passwordController.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(
                              title: 'Aplicación de prueba',
                              userNameController: user['nombre_usuario'],
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Datos incorrectos')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Por favor llena los campos')),
                      );
                    }
                  },
                ),
                LinkButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(
                          title: 'Crear cuenta',
                        ),
                      ),
                    );
                  },
                  text: 'Crear cuenta nueva',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //@override
  //void dispose() {
  //  if (_connection != null) {
  //    MySQLService.closeConnection(_connection!);
  //  }
  //  super.dispose();
  //}
}
