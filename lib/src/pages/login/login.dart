import 'package:app_test/core/route.dart';
import 'package:app_test/core/templates/template.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dbUsers = DBUsers();

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
                  labelText: 'Correo electrónico o Nombre de usuario',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce un correo electrónico o nombre de usuario válido';
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
                      final user = await dbUsers
                          .getUserByEmailOrUsername(emailController.text);
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
}
