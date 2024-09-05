import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEditing = false; // Controle de edição para os campos

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('userName') ?? '';
    _emailController.text = prefs.getString('userEmail') ?? '';
    _cpfController.text = prefs.getString('userCpf') ?? '';
    _passwordController.text = prefs.getString('userPassword') ?? '';
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userEmail', _emailController.text);
    await prefs.setString('userCpf', _cpfController.text);
    await prefs.setString('userPassword', _passwordController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil atualizado com sucesso')),
    );

    setState(() {
      _isEditing = false; // Define o modo de edição para falso após salvar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveProfile(); // Salva se estiver em modo de edição
              } else {
                setState(() {
                  _isEditing = true; // Entra no modo de edição
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(
                controller: _nameController,
                labelText: 'Nome',
                enabled: _isEditing,
              ),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
                enabled: _isEditing,
              ),
              _buildTextField(
                controller: _cpfController,
                labelText: 'CPF',
                enabled: _isEditing,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Senha',
                enabled: _isEditing,
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool enabled = true,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }
}
