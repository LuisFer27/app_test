import 'package:app_test/core/libraries.dart';
import 'package:app_test/core/pages.dart';

class LogoutController {
  static void logout(
    BuildContext context,
    Function setStateCallback,
    String? userNameController,
    String? userEmail,
    String? userFullName,
    Widget? currentPage,
  ) {
    setStateCallback(() {
      // Restablece la información del usuario
      userNameController = null;
      userEmail = null;
      userFullName = null;
      currentPage = DashPageState();
    });

    // Navega a la página de inicio de sesión y elimina todas las rutas anteriores
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }
}
