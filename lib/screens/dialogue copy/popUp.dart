import 'package:flutter/material.dart';

class Dialogo {
  final BuildContext context;

  Dialogo(this.context);

  //FUNÇÃO PARA ABRIR O POP-UP
  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Column(
            children: [
              Icon(
                Icons.published_with_changes_rounded,
                size: 70,
              ),
              const SizedBox(width: 8),
            ],
          ),
          content: Text(
            'Cadastro concluido.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      );
}
