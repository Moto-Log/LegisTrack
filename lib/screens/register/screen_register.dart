import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/dataBaseRegister.dart';
import '../dialogue/popUp.dart';
import '../login/login.dart';
import '../validation/validators.dart';

class PaginaCadastro extends StatefulWidget {
  const PaginaCadastro({super.key});

  @override
  State<PaginaCadastro> createState() => _PaginaCadastroState();
}

class _PaginaCadastroState extends State<PaginaCadastro> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerIdade = TextEditingController();
  final TextEditingController _controllerCpf = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  final bool _isNomeValid = true;
  bool _isCpfValid = true;
  final bool _isIdadeValid = true;
  final bool _isEmailValid = true;
  final bool _isSenhaValid = true;

  void _validateCpf() {
    setState(() {
      _isCpfValid = validations.isValidCpf(_controllerCpf.text);
    });
  }

  Future<void> adicionarValores(
      String nome, String idade, String cpf, String email, String senha) async {
    if (nome.isNotEmpty &&
        idade.isNotEmpty &&
        cpf.isNotEmpty &&
        email.isNotEmpty &&
        senha.isNotEmpty) {
      final valorModel = ValorModel(
          nome: nome, idade: idade, cpf: cpf, email: email, senha: senha);
      final dbHelper = DbHelper();
      await dbHelper.insert(valorModel.toMap());
    } else {
      print("Todos os campos são obrigatórios.");
    }
  }

  bool _showPassword = false;

  final maskFormatterIdade = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final maskFormatterCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final OutlineInputBorder customBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: const BorderSide(color: Colors.black),
  );

  String get nomeRecebido => _controllerNome.text;
  String get idadeRecebido => _controllerIdade.text;
  String get cpfRecebido => _controllerCpf.text;
  String get emailRecebido => _controllerEmail.text;
  String get senhaRecebido => _controllerSenha.text;

  @override
  Widget build(BuildContext context) {
    void printDatabaseValues() async {
      final dbHelper = DbHelper();
      final allRows = await dbHelper.queryAllRows();
      allRows.forEach((row) {
        print(
            'ID: ${row['id']}, Nome: ${row['nome']}, Idade: ${row['idade']}, CPF: ${row['cpf']}, Email: ${row['email']}, Senha: ${row['senha']}');
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //CHAMANDO A CLASSE PARA TITULO DA PAGINA
                //MeuTextoCadastro(),
                //SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    text: 'Cadastro',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                ),

                //CAMPO NOME
                TextField(
                  controller: _controllerNome,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Digite seu Nome',
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 233, 232, 232),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isNomeValid ? Colors.grey : Colors.red,
                          width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isNomeValid ? Colors.grey : Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //CAMPO IDADE
                TextField(
                  inputFormatters: [maskFormatterIdade],
                  keyboardType: TextInputType.number,
                  controller: _controllerIdade,
                  decoration: InputDecoration(
                    labelText: 'Idade',
                    hintText: 'Digite sua idade',
                    prefixIcon: const Icon(Icons.calendar_month),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 233, 232, 232),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isIdadeValid ? Colors.grey : Colors.red,
                          width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isIdadeValid ? Colors.grey : Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //CAMPO CPF
                TextField(
                  inputFormatters: [maskFormatterCpf],
                  keyboardType: TextInputType.number,
                  controller: _controllerCpf,
                  decoration: InputDecoration(
                    labelText: 'Cpf',
                    hintText: 'Informe seu Cpf',
                    prefixIcon: const Icon(Icons.call_to_action_outlined),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 233, 232, 232),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isCpfValid ? Colors.grey : Colors.red,
                          width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isCpfValid ? Colors.grey : Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        _isCpfValid = true;
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),

                //CAMPO EMAIL
                TextField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'seuemail@email.com',
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 233, 232, 232),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isEmailValid ? Colors.grey : Colors.red,
                          width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isEmailValid ? Colors.grey : Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //CAMPO SENHA
                TextField(
                  controller: _controllerSenha,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Digite sua senha',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 233, 232, 232),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _isSenhaValid ? Colors.grey : Colors.red,
                          width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _isSenhaValid ? Colors.grey : Colors.red,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //BOTAO CADASTRAR
                ElevatedButton(
                  onPressed: () {
                    _validateCpf();
                    if (nomeRecebido.isEmpty ||
                        idadeRecebido.isEmpty ||
                        cpfRecebido.isEmpty ||
                        emailRecebido.isEmpty ||
                        senhaRecebido.isEmpty) {
                      //DatabaseCadastro.instance.closeDatabase();
                      showDialog(context: context, builder: (BuildContext build) {
                        return AlertDialog(
                          title: const Text('Aviso!'),
                          content: const Text('Todos os campos devem estar preenchidos'),
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
                    } else {
                      if (_isCpfValid) {
                        adicionarValores(
                          nomeRecebido,
                          idadeRecebido,
                          cpfRecebido,
                          emailRecebido,
                          senhaRecebido,
                        );

                        //ABRE UMA CAIXA (POPUP)
                        Dialogo dialogo = Dialogo(context);
                        dialogo.dialogCadastro();
                        Timer(const Duration(seconds: 1), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        });

                        //LIMPA OS CAMPOS
                        _controllerNome.clear();
                        _controllerIdade.clear();
                        _controllerCpf.clear();
                        _controllerEmail.clear();
                        _controllerSenha.clear();

                        printDatabaseValues();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Dados Inválidos')),
                        );
                      }
                      ;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),

                //BOTAO LOGIN
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 49, 46, 46),
                  ),
                  child: const Text(
                    'Já Tenho Conta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
