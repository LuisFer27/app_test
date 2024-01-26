import 'package:flutter/material.dart';
import 'package:app_test/src/pages/homescreen/home_screen.dart';
import 'package:app_test/src/controllers/connection/data_base_controller.dart';
import 'package:mysql1/mysql1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MySqlConnection? _connection;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectToMySQL();
  }

  Future<void> _connectToMySQL() async {
    try {
      _connection = await MySQLService.connectToMySQL();
    } catch (e) {
      // Manejar errores de conexión aquí
      print('Error de conexión: $e');
    }
  }

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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo electrónico"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce un correo electrónico valido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Contraseña"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce tu contraseña';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_connection != null &&
                          _formKey.currentState!.validate()) {
                        var results = await MySQLService.queryDatabase(
                          _connection!,
                          emailController.text,
                          passwordController.text,
                        );

                        if (results.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                title: 'Aplicación de prueba',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Datos incorrectos')),
                          );
                        }
                      } else {
                        // Manejar el caso donde la conexión es nula
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error de conexión')),
                        );
                      }
                    },
                    child: const Text('Iniciar sesión'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_connection != null) {
      MySQLService.closeConnection(_connection!);
    }
    super.dispose();
  }
}
