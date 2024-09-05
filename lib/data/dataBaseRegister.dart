import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

// Modelo de dados para um usuário
class ValorModel {
  final String nome;
  final String idade;
  final String cpf;
  final String email;
  final String senha;

  ValorModel({
    required this.nome,
    required this.idade,
    required this.cpf,
    required this.email,
    required this.senha,
  });

  // Converte o objeto para um Map para facilitar a inserção no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'cpf': cpf,
      'email': email,
      'senha': senha,
    };
  }
}

// Classe que gerencia o banco de dados
class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  static Database? _database;

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._internal();

  // Inicializa o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  // Cria o banco de dados e define sua estrutura
  Future<Database> _initDb() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'databaseregister.db');
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    } catch (e) {
      print("Erro ao inicializar o banco de dados: $e");
      rethrow;
    }
  }

  // Cria a tabela 'RegisterUser' no banco de dados
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE RegisterUser (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL,
        idade TEXT NOT NULL,
        cpf TEXT NOT NULL,
        email TEXT NOT NULL,
        senha TEXT NOT NULL
      )
    ''');
  }

  // Insere um novo registro no banco de dados
  Future<int> insert(Map<String, dynamic> row) async {
    try {
      Database db = await database;
      return await db.insert('RegisterUser', row);
    } catch (e) {
      print("Erro ao inserir registro: $e");
      rethrow;
    }
  }

  // Consulta todos os registros da tabela
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    try {
      Database db = await database;
      return await db.query('RegisterUser');
    } catch (e) {
      print("Erro ao consultar registros: $e");
      rethrow;
    }
  }

  // Atualiza um registro existente no banco de dados
  Future<int> update(Map<String, dynamic> row) async {
    try {
      Database db = await database;
      int id = row['id'];
      return await db.update('RegisterUser', row, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Erro ao atualizar registro: $e");
      rethrow;
    }
  }

  // Exclui um registro do banco de dados
  Future<int> delete(int id) async {
    try {
      Database db = await database;
      return await db.delete('RegisterUser', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Erro ao excluir registro: $e");
      rethrow;
    }
  }
}

// Função para adicionar valores no banco de dados
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
    try {
      await dbHelper.insert(valorModel.toMap());
    } catch (e) {
      print("Erro ao adicionar valores: $e");
    }
  } else {
    print("Todos os campos são obrigatórios.");
  }
}
