import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login.dart';

class PaginaCadastro extends StatefulWidget {
  const PaginaCadastro({super.key});

  @override
  State<PaginaCadastro> createState() => _PaginaCadastroState();
}

class _PaginaCadastroState extends State<PaginaCadastro> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerAniversario = TextEditingController();
  final TextEditingController _controllerCpf = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  final maskFormatterAniversario = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final maskFormatterCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Acompanhe os projetos de lei de onde e quando quiser! Realize seu cadastro agora.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _controllerNome,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controllerAniversario,
                decoration: const InputDecoration(labelText: 'Aniversário (DD/MM/AAAA)'),
                keyboardType: TextInputType.number,
                inputFormatters: [maskFormatterAniversario],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controllerCpf,
                decoration: const InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
                inputFormatters: [maskFormatterCpf],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controllerSenha,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onRegisterButtonPressed,
                child: const Text('Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text('Já possui conta? Faça login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRegisterButtonPressed() async {
    if (_areFieldsValid()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', _controllerNome.text);
      await prefs.setString('userAniversario', _controllerAniversario.text);
      await prefs.setString('userCpf', _controllerCpf.text);
      await prefs.setString('userEmail', _controllerEmail.text);
      await prefs.setString('userPassword', _controllerSenha.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );

      _clearFields();
    } else {
      _showErrorSnackBar('Dados Inválidos');
    }
  }

  bool _areFieldsValid() {
    return _controllerNome.text.isNotEmpty &&
        _controllerAniversario.text.isNotEmpty &&
        _controllerCpf.text.isNotEmpty &&
        _controllerEmail.text.isNotEmpty &&
        _controllerSenha.text.isNotEmpty;
  }

  void _clearFields() {
    _controllerNome.clear();
    _controllerAniversario.clear();
    _controllerCpf.clear();
    _controllerEmail.clear();
    _controllerSenha.clear();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
