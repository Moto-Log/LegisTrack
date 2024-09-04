class validations {
  static bool isValidCpf(String cpf) {
  cpf = cpf.replaceAll('.', '').replaceAll('-', '');
  if (cpf.length != 11) {
    return false;
  }

  if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
    return false;
  }
  int sum = 0;
  for (int i = 0; i < 9; i++) {
    sum += int.parse(cpf[i]) * (10 - i);
  }
  int firstDigit = (sum * 10) % 11;
  if (firstDigit == 10) {
    firstDigit = 0;
  }
  sum = 0;
  for (int i = 0; i < 10; i++) {
    sum += int.parse(cpf[i]) * (11 - i);
  }
  int secondDigit = (sum * 10) % 11;
  if (secondDigit == 10) {
    secondDigit = 0;
  }
  return firstDigit == int.parse(cpf[9]) && secondDigit == int.parse(cpf[10]);
  }
}