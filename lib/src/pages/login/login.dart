import 'package:flutter/material.dart';
//import 'package:app_test/src/widgets/Buttons/btns.dart';
//import 'package:app_test/src/controllers/connection/data_base_controller.dart';
import 'package:app_test/src/pages/homescreen/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //void initState() {
  //   super.initState();
  //   _connectToMySQL();
  // }
  //@override
  //void dispose() {
  //  _connection.close(); // Cerrar la conexión al salir de la página
  //  super.dispose();
  //}

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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Consulta a MySQL
                        //var results = await _connection.query(
                        //  'SELECT * FROM tu_tabla WHERE email = ? AND password = ?',
                        //  [emailController.text, passwordController.text],
                        //);
                        //if (results.isNotEmpty) {
                        //  Navigator.push(
                        //    context,
                        //    MaterialPageRoute(
                        //      builder: (context) => const MyHomePage(
                        //        title: 'Aplicación de prueba',
                        //      ),
                        //    ),
                        //  );
                        //}
                        if (emailController.text == "admin@mail.com" &&
                            passwordController.text == "123") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: 'Aplicación de prueba',
                                    )),
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
}
