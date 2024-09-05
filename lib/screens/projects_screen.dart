import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:legistrack/models/project.dart';
import 'package:legistrack/screens/project_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Project> _projects = []; // Lista de todos os projetos carregados
  List<Project> _filteredProjects = []; // Lista de projetos filtrados com base na pesquisa
  List<Project> _favoriteProjects = []; // Lista de projetos favoritos
  bool _isLoading = true; // Controle de carregamento
  String? _errorMessage; // Mensagem de erro, se houver

  @override
  void initState() {
    super.initState();
    _loadProjects(); // Carrega os projetos ao inicializar a tela
  }

  Future<void> _loadProjects() async {
    try {
      final response = await http.get(Uri.parse(
          'https://dadosabertos.camara.leg.br/api/v2/proposicoes?ordem=DESC&ordenarPor=id'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var data = jsonData['dados'];
        setState(() {
          _projects = data.map<Project>((project) => Project.fromJson(project)).toList();
          _filteredProjects = _projects;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Erro ao carregar os dados: ${response.reasonPhrase}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Erro ao carregar os dados: $e";
        _isLoading = false;
      });
    }
  }

  void _searchProjects(String query) {
    setState(() {
      _filteredProjects = _projects.where((project) {
        return project.ementa.toLowerCase().contains(query.toLowerCase()) ||
            project.siglaTipo.toLowerCase().contains(query.toLowerCase()) ||
            project.ano.toString().contains(query);
      }).toList();
    });
  }

  void _toggleFavorite(Project project) {
    setState(() {
      if (_favoriteProjects.contains(project)) {
        _favoriteProjects.remove(project); // Remove dos favoritos
      } else {
        _favoriteProjects.add(project); // Adiciona aos favoritos
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projetos de Lei'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Qual projeto de lei deseja acompanhar?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Pesquisar',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: _searchProjects,
                      ),
                    ),
                    Expanded(
                      child: _buildProjectList(),
                    ),
                  ],
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Projetos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Já está na tela de projetos
          } else {
            Navigator.pushNamed(context, '/favorites');
          }
        },
      ),
    );
  }

  Widget _buildProjectList() {
    return ListView.builder(
      itemCount: _filteredProjects.length,
      itemBuilder: (context, index) {
        Project project = _filteredProjects[index];
        bool isFavorite = _favoriteProjects.contains(project);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectScreen(project.id),
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.ementa),
                  Text('Sigla Tipo: ${project.siglaTipo}'),
                  Text('Número: ${project.numero.toString()}'),
                  Text('Ano: ${project.ano.toString()}'),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isFavorite ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () => _toggleFavorite(project),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
