class Validations {
  String? validateField(String value, int maxLength) {
    if (value.isEmpty) {
      return 'Por favor rellena el campo';
    } else if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$').hasMatch(value)) {
      return 'Solo se permiten letras y espacios';
    } else if (value.length > maxLength) {
      return 'El campo no puede tener más de $maxLength caracteres alfabéticos';
    }
    return null;
  }

  String? validateFieldNoRequired(String? value, int maxLength) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$').hasMatch(value)) {
        return 'Solo se permiten letras y espacios';
      } else if (value.length > maxLength) {
        return 'El campo no puede tener más de $maxLength caracteres alfabéticos';
      }
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Por favor introduce una contraseña';
    } else if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()-_=+]).*$')
        .hasMatch(value)) {
      return 'La contraseña debe contener al menos una letra, un número y un carácter especial';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Por favor introduce un correo electrónico';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor introduce un correo electrónico válido';
    }
    return null;
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Por favor introduce un nombre de usuario';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'El nombre de usuario solo puede contener letras, números y guiones bajos';
    } else if (value.length < 4) {
      return 'El nombre de usuario debe tener al menos 4 caracteres';
    } else if (value.length > 20) {
      return 'El nombre de usuario no puede tener más de 20 caracteres';
    }
    return null;
  }
}
