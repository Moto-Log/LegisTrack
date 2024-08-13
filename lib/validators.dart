import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > 11) {
      return oldValue;
    }
    String cpf = newValue.text;
    cpf = cpf.replaceAll('.', '').replaceAll('-', '');
    if (cpf.length > 11) {
      cpf = cpf.substring(0, 11);
    }
    String formattedCpf = '';
    for (int i = 0; i < cpf.length; i++) {
      if (i == 3 || i == 6) {
        formattedCpf += '.';
      }
      if (i == 9) {
        formattedCpf += '-';
      }
      formattedCpf += cpf[i];
    }
    return TextEditingValue(
      text: formattedCpf,
      selection: TextSelection.collapsed(offset: formattedCpf.length),
    );
  }
}

class validations {
  static bool isValidCpf(String cpf) {
  cpf = cpf.replaceAll('.', '').replaceAll('-', '');
  if (cpf.length != 11) {
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