//LOGICA PARA VERIFICAR CPF
  bool isValidCpf(String cpf) {
    // Remove caracteres não numéricos
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    // Verifica se o CPF tem 11 dígitos
    if (cpf.length != 11) {
      return false;
    }

    // Verifica se todos os dígitos são iguais (ex: 111.111.111-11)
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return false;
    }

    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstCheckDigit = (sum * 10) % 11;
    if (firstCheckDigit == 10) {
      firstCheckDigit = 0;
    }

    // Verifica o primeiro dígito verificador
    if (firstCheckDigit != int.parse(cpf[9])) {
      return false;
    }

    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondCheckDigit = (sum * 10) % 11;
    if (secondCheckDigit == 10) {
      secondCheckDigit = 0;
    }

    // Verifica o segundo dígito verificador
    if (secondCheckDigit != int.parse(cpf[10])) {
      return false;
    }
    return true;
  }