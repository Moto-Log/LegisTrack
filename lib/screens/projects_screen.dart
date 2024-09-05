/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:legistrack/models/project.dart';// assuming you have a Project model in a separate file

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
}

class ProjectsScreenState extends State<ProjectsScreen> {
  final _searchController = TextEditingController();
  List<Project> _projects = [];
  List<Project> _filteredProjects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    // Carregar a lista de projetos de lei da API da Câmara - Bugado no momento
    final response = await http.get(Uri.parse('https://dadosabertos.camara.leg.br/api/v2/proposicoes?ordem=DESC&ordenarPor=id'));
    final jsonData = jsonDecode(response.body);
    var data = jsonData['dados'];
    _projects = data.map<Project>((project) => Project.fromJson(project)).toList();
    _filteredProjects = _projects;
    setState(() {});
  }

  void _searchProjects(String query) {
    _filteredProjects = _projects.where((project) {
      return project.ementa.toLowerCase().contains(query.toLowerCase()) ||
            project.siglaTipo.toLowerCase().contains(query.toLowerCase()) ||
            project.ano.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projetos de Lei'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
            child: ListView.builder(
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                Project project = _filteredProjects[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(project.ementa),
                        Text('Sigla Tipo: ${project.siglaTipo}'),
                        Text('Número: ${project.numero.toString()}'),
                        Text('Ano: ${project.ano.toString()}'),
                        Text('Sigla: ${project.siglaTipo}')
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:legistrack/models/project.dart'; // assumindo que você tem um modelo Project em um arquivo separado
import 'project_pages.dart';
import 'bottom_navigation.dart';
import 'package:legistrack/main.dart';
import 'package:legistrack/screens/project_screen.dart';
int _currentIndex = 0;
int _pageController = 0;

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ProjectsScreenState createState() => ProjectsScreenState();
  }
  

class ProjectsScreenState extends State<ProjectsScreen> {
  final _searchController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);
  List<Project> _projects = [];
  List<Project> _filteredProjects = [];
  List<Project> _favoriteProjects = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _toggleFavorite(Project project) {
    if (_favoriteProjects.contains(project)) {
      _favoriteProjects.remove(project);
    } else {
      _favoriteProjects.add(project);
    }
    setState(() {
    
  }); 
  }

  Future<void> _loadProjects() async {
    // Carregar a lista de projetos de lei da API da Câmara - Bugado no momento
    final response = await http.get(Uri.parse('https://dadosabertos.camara.leg.br/api/v2/proposicoes?ordem=DESC&ordenarPor=id'));
    final jsonData = jsonDecode(response.body);
    var data = jsonData['dados'];
    _projects = data.map<Project>((project) => Project.fromJson(project)).toList();
    _filteredProjects = _projects;
    setState(() {});
  }

  void _searchProjects(String query) {
    _filteredProjects = _projects.where((project) {
      return project.ementa.toLowerCase().contains(query.toLowerCase()) ||
            project.siglaTipo.toLowerCase().contains(query.toLowerCase()) ||
            project.ano.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {});
  }

  void _showProjectDialog(Project project) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(project.ementa),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sigla Tipo: ${project.siglaTipo}'),
              Text('Número: ${project.numero.toString()}'),
              Text('Ano: ${project.ano.toString()}'),
              Text('Sigla: ${project.siglaTipo}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projetos de Lei'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                ListView.builder(
                  itemCount: _filteredProjects.length,
                  itemBuilder: (context, index) {
                    Project project = _filteredProjects[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectScreen(project.id)),
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
                              Text('Sigla: ${project.siglaTipo}'),
                              IconButton(
                                icon: Icon(
                                  _favoriteProjects.contains(project) ? Icons.star : Icons.star_border
                                  ),
                                  color: _favoriteProjects.contains(project) ? Colors.yellow[700] : null,
                                onPressed: () {
                                  _toggleFavorite(project);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 10.0, // adjust the gap between items
                  runSpacing: 8.0, // adjust the gap between rows
                  children: _favoriteProjects.map((project) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectScreen(project.id)),
                        );
                      },
                      child: Container(
                        width: 175.0, // adjust the width of each item
                        height: 175.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.yellow,
                            width: 3, // Largura da borda
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(project.ementa, maxLines: 2, overflow: TextOverflow.ellipsis),
                            Text('Sigla Tipo: ${project.siglaTipo}'),
                            Text('Número: ${project.numero.toString()}'),
                            Text('Ano: ${project.ano.toString()}'),
                            Text('Sigla: ${project.siglaTipo}'),
                            IconButton(
                              icon: Icon(Icons.star),
                              color: Colors.yellow[700],
                              onPressed: () {
                                _toggleFavorite(project);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    );
                  }).toList(),
                )
            )],
            
              )
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow[700], // Cor da bottom bar
        selectedItemColor: Colors.white, // Cor do texto dos itens selecionados
        unselectedItemColor: Colors.black, // Cor do texto dos itens não selecionados
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Projetos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
