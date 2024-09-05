import 'package:flutter/material.dart';

// Classe responsável por gerenciar diálogos pop-up
class Dialogo {
  final BuildContext context;

  Dialogo(this.context);

  // Função para exibir um pop-up de confirmação de cadastro concluído
  Future<void> dialogCadastro() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            const Icon(
              Icons.published_with_changes_rounded,
              size: 70,
            ),
            const SizedBox(height: 8), // Ajuste na altura do espaçamento
          ],
        ),
        content: const Text(
          'Cadastro concluído.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
