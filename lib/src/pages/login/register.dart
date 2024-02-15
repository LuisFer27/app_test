import 'package:app_test/core/route.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController secondLastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dbUsers = DBUsers();
  final Validations validations = Validations(); // Instancia de Validations
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
                    return validations.validateField(value ?? '',
                        50); // Convertir value a String y proporcionar una cadena vacía si es nulo
                  },
                ),
                TextInput(
                  controller: lastNameController,
                  labelText: 'Primer apellido',
                  validator: (value) {
                    return validations.validateField(value ?? '',
                        20); // Convertir value a String y proporcionar una cadena vacía si es nulo
                  },
                ),
                TextInput(
                    controller: secondLastNameController,
                    labelText: 'Segundo apellido',
                    validator: (value) {
                      validations.validateFieldNoRequired(value, 50);
                      return null;
                    }),
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
                Btns(
                  menuText: 'Registrar',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // Crear un mapa con los datos del usuario
                      Map<String, dynamic> user = {
                        'email': emailController.text,
                        'nombre': nameController.text,
                        'primer_apellido': lastNameController.text,
                        'segundo_apellido': secondLastNameController.text,
                        'contrasena': passwordController.text,
                        'nombre_usuario': userNameController.text,
                      };

                      // Insertar el usuario en la base de datos
                      await dbUsers.insertUser(user);

                      // Mostrar mensaje de éxito y regresar a la pantalla de inicio
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Usuario registrado con éxito')),
                      );

                      // Regresar a la pantalla de inicio
                      Navigator.pop(context);
                    } else {
                      // Mostrar mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No se pudo registrar el usuario')),
                      );
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
