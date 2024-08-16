import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class ValorModel {
  final String nome;
  final String idade;
  final String email;
  final String senha;

  ValorModel({required this.nome, required this.idade, required this.email, required this.senha});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'email': email,
      'senha': senha,
    };
  }
}

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  static Database? _database;

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'mydatabase.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE RegisterUser (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL,
        idade TEXT NOT NULL,
        email TEXT NOT NULL,
        senha TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('RegisterUser', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await database;
    return await db.query('RegisterUser');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('RegisterUser', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete('RegisterUser', where: 'id = ?', whereArgs: [id]);
  }
}

Future<void> adicionarValores(String nome, String idade, String email, String senha) async {
  if (nome.isNotEmpty && idade.isNotEmpty && email.isNotEmpty && senha.isNotEmpty) {
    final valorModel = ValorModel(nome: nome, idade: idade, email: email, senha: senha);
    final dbHelper = DbHelper();
    await dbHelper.insert(valorModel.toMap());
  } else {
    print("Todos os campos são obrigatórios.");
  }
}
