import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/project.dart';

class ProjectScreen extends StatefulWidget {
  final int propositionId;

  ProjectScreen(this.propositionId, {super.key});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  Project? _project;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProject();
  }

  Future<void> _loadProject() async {
    try {
      final response = await http.get(Uri.parse(
          'https://dadosabertos.camara.leg.br/api/v2/proposicoes/${widget.propositionId}'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var data = jsonData['dados'];
        setState(() {
          _project = Project.fromJson(data);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Status da Proposição"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView( // Adicionei o SingleChildScrollView
                    child: _buildProjectDetails(),
                  ),
                ),
    );
  }

  Widget _buildProjectDetails() {
    return Column(
      children: [
        ListTile(
          title: const Text('Ano'),
          subtitle: Text(_project?.ano.toString() ?? ''),
        ),
        ListTile(
          title: const Text('Ementa'),
          subtitle: Text(_project?.ementa ?? ''),
        ),
        ListTile(
          title: const Text('Âmbito'),
          subtitle: Text(_project?.statusProposicao?.ambito ?? ''),
        ),
        ListTile(
          title: const Text('Despacho'),
          subtitle: Text(_project?.statusProposicao?.despacho ?? ''),
        ),
        ListTile(
          title: const Text('Descrição da Situação'),
          subtitle: Text(_project?.statusProposicao?.descricaoSituacao ?? ''),
        ),
        ListTile(
          title: const Text('Descrição da Tramitação'),
          subtitle: Text(_project?.statusProposicao?.descricaoTramitacao ?? ''),
        ),
        ListTile(
          title: const Text('Regime'),
          subtitle: Text(_project?.statusProposicao?.regime ?? ''),
        ),
      ],
    );
  }
}
