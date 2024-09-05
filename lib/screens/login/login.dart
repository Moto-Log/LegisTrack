import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../projects_screen.dart'; // Corrigir importação para a tela de projetos
import '../register/screen_register.dart'; // Importação da tela de cadastro

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  void _checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (loggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ProjectsScreen()));
    }
  }

  Future<void> _login() async {
    // Aqui vai sua lógica de validação de login
    if (_controllerEmail.text == "teste@exemplo.com" && _controllerSenha.text == "123456") {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Define que o usuário está logado
      await prefs.setString('userEmail', _controllerEmail.text); // Salva o e-mail do usuário
      await prefs.setString('userName', "Nome do Usuário"); // Exemplo de nome de usuário
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ProjectsScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciais inválidas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50), // Ajuste do topo
                child: const FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Image(
                        image: AssetImage('src/archives/login_img.png'))),
              ),
              TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _controllerSenha,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Entrar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaginaCadastro()),
                  );
                },
                child: const Text('Não possui conta? Se cadastre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
