import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legisTrack/data/dataBaseRegister.dart';

import '../../validators.dart';
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
  //String _cpf = '';
  //String _senha = '';
  bool _obscureText = true;

  //final _controllers = [TextEditingController(), TextEditingController()];
  final _focusNodes = [FocusNode(), FocusNode()];
  final _scrollController = ScrollController();

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
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Future<bool> _compareValue() async {
    final cpfValue = _controllerCpf.text;
    final senhaValue = _controllerSenha.text;
    try {
      final dbHelper = DbHelper();
      final List<Map<String, dynamic>> maps = await dbHelper.queryAllRows();
      for (var map in maps) {
        if (map['cpf'] == cpfValue && map['senha'] == senhaValue) {
          print('Valor encontrado no banco de dados!');
          return true;
        }
      }
      print('Valor não encontrado');
      return false;
    } catch (e) {
      print('Erro ao acessar o banco de dados: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: [
              Container(
                  margin: EdgeInsets.only(top: 50), // Set the margin here
                  child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Image(
                          image: AssetImage('src/archives/login_img.png')))),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 48,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, insira seu CPF';
                          }
                          if (!validations.isValidCpf(value)) {
                            return 'CPF inválido';
                          }
                          return null;
                        },
                        onSaved: (value) => _controllerCpf.text = value!,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
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
                            border: OutlineInputBorder(),
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
                        onSaved: (value) => _controllerSenha.text = value!,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          bool valueFound = await _compareValue();
                          if (valueFound) {
                            _controllerCpf.clear();
                            _controllerSenha.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProjectsScreen()),
                            );
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
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(225, 255, 235, 59))),
                        child: Text('Entrar',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaginaCadastro()),
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
