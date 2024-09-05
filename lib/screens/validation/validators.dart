class Validations {
  // Método para validar CPF
  static bool isValidCpf(String cpf) {
    // Remove pontos e traços do CPF
    cpf = cpf.replaceAll('.', '').replaceAll('-', '');
    
    // Verifica se o CPF possui 11 dígitos
    if (cpf.length != 11) {
      return false;
    }

    // Verifica se todos os dígitos são iguais
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstDigit = (sum * 10) % 11;
    if (firstDigit == 10) {
      firstDigit = 0;
    }

    // Verifica o primeiro dígito
    if (firstDigit != int.parse(cpf[9])) {
      return false;
    }

    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondDigit = (sum * 10) % 11;
    if (secondDigit == 10) {
      secondDigit = 0;
    }

    // Verifica o segundo dígito
    return secondDigit == int.parse(cpf[10]);
  }

  // Método para validar e-mail
  static bool isValidEmail(String email) {
    // Regex para validar formato de e-mail
    String pattern =
        r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  // Método para validar senha forte
  static bool isValidPassword(String password) {
    // Regex para garantir que a senha tenha pelo menos 8 caracteres, incluindo uma letra maiúscula, uma minúscula, um número e um caractere especial
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  // Método para obter mensagens de erro de validação
  static String? getValidationError(String value, String fieldType) {
    switch (fieldType) {
      case 'CPF':
        return isValidCpf(value) ? null : 'CPF inválido';
      case 'Email':
        return isValidEmail(value) ? null : 'E-mail inválido';
      case 'Senha':
        return isValidPassword(value)
            ? null
            : 'Senha fraca. A senha deve ter pelo menos 8 caracteres, incluindo uma letra maiúscula, uma minúscula, um número e um caractere especial.';
      default:
        return null;
    }
  }
}
