import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pl_watch/models/project.dart';// assuming you have a Project model in a separate file

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
    // final response = await http.get(Uri.parse('https://api.camara.leg.br/...'));
    // final jsonData = jsonDecode(response.body);
    // _projects = jsonData.map((project) => Project.fromJson(project)).toList();
    // _filteredProjects = _projects;
    setState(() {});
  }

  void _searchProjects(String query) {
    _filteredProjects = _projects.where((project) {
      return project.ementa.toLowerCase().contains(query.toLowerCase()) ||
            project.apelido.toLowerCase().contains(query.toLowerCase()) ||
            project.palavrasChave.toLowerCase().contains(query.toLowerCase());
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
                        Text(project.apelido),
                        Text('Sigla Tipo: ${project.siglaTipo}'),
                        Text('Número: ${project.numero}'),
                        Text('Ano: ${project.ano}'),
                        Text('Palavras Chave: ${project.palavrasChave}'),
                        Text('Assunto: ${project.assunto}'),
                        Text('Situação: ${project.situacao}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Data Situação: ${project.dataSituacao}'),
                            Text('Data Publicação: ${project.dataPublicacao}'),
                            IconButton(
                              icon: const Icon(Icons.favorite),
                              onPressed: () {
                                // Marcar como favorito
                              },
                            ),
                          ],
                        ),
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
}