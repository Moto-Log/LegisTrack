import 'package:flutter/material.dart';
import 'package:legistrack/data/dataBaseRegister.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../validation/validators.dart';
import '../projects_screen.dart';
import '../register/screen_register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerCpf = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final _focusNodes = [FocusNode(), FocusNode()];
  final _scrollController = ScrollController();

  final maskFormatterCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((node) => node.addListener(_onFocusChange));
  }

  @override
  void dispose() {
    _focusNodes.forEach((node) => node.removeListener(_onFocusChange));
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  void _onFocusChange() {
    _focusNodes.forEach((node) {
      if (node.hasFocus) {
        _scrollToNode(node);
      }
    });
  }

  void _scrollToNode(FocusNode node) {
    _scrollController.animateTo(
      node.offset.dy,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Future<String> _compareValue() async {
    final cpfValue = _controllerCpf.text;
    final senhaValue = _controllerSenha.text;
    try {
      final dbHelper = DbHelper();
      final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows();
      for (var map in maps) {
        if (map['cpf'] == cpfValue && map['senha'] == senhaValue) {
          // print('Valor encontrado no banco de dados!');
          return "Found";
        }
      }
      // print('Valor não encontrado');
      return "Usuário e/ou senha inválidos!";
    } catch (e) {
      // print('Erro ao acessar o banco de dados: $e');
      return "Erro ao acessar o banco de dados: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 50), // Set the margin here
                  child: const FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Image(
                          image: AssetImage('src/archives/login_img.png')))),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 48,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'CPF',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      TextFormField(
                        //controller: _controllers[0],
                        keyboardType: TextInputType.number,
                        controller: _controllerCpf,
                        focusNode: _focusNodes[0],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, insira seu CPF';
                          }
                          if (!validations.isValidCpf(value)) {
                            return 'CPF inválido';
                          }
                          return null;
                        },
                        onChanged: (value) => _controllerCpf.text = value,
                        inputFormatters: [maskFormatterCpf],
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Senha',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      TextFormField(
                        //controller: _controllers[1],
                        controller: _controllerSenha,
                        focusNode: _focusNodes[1],
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, insira sua senha';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        onChanged: (value) => _controllerSenha.text = value,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          String valueFound = await _compareValue();
                          if (valueFound == "Found") {
                            _controllerCpf.clear();
                            _controllerSenha.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProjectsScreen()),
                            );
                          }
                          else {
                            showDialog(context: context, builder: (BuildContext build) {
                              return AlertDialog(
                                title: const Text('Aviso!'),
                                content: Text(valueFound),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                          }
                          /*if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProjectsScreen()),
                            );
                          }*/
                        },
                        style: ButtonStyle(
                            shape: const WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(225, 255, 235, 59))),
                        child: const Text('Entrar',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PaginaCadastro()),
                            );
                          },
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Cadastre-se',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline)))),
                    ],
                  ),
                ),
              ),
            ])));
  }
}