import 'package:app_test/core/route.dart';

class LogoutController {
  static void logout(
    BuildContext context,
    Function setStateCallback,
    int? userId,
    String? userEmail,
    String? userName,
    String? userFullName,
    Widget? currentPage,
  ) {
    setStateCallback(() {
      // Restablece la información del usuario
      userId = null;
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
