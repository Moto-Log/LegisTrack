import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/project.dart';

class ProjectScreen extends StatefulWidget {
  int _propositionId;

  ProjectScreen(this._propositionId, {super.key});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {

  Project? _project;

@override
  void initState() {
    super.initState();
    _loadProjects();
  }
  

  Future<void> _loadProjects() async {
    // Carregar a lista de projetos de lei da API da Câmara - Bugado no momento
    final response = await http.get(Uri.parse('https://dadosabertos.camara.leg.br/api/v2/proposicoes/${widget._propositionId}'));
    final jsonData = jsonDecode(response.body);
    var data = jsonData['dados'];
    _project = Project.fromJson(data);
    setState(() {});
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(_project != null ? _project!.statusProposicao!.ambito! : "Proposição")
  //     ),
  //     body:
  //       const Padding(
  //         padding: 
  //           EdgeInsets.only(
  //             top: 20.0,
  //             left: 10.0,
  //             right: 20.0,
  //             bottom: 10.0
  //           ),
  //           child: Column (
  //             children: [
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "DescricaoTipo",
  //                   style: TextStyle(
  //                     fontSize: 48,
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold
  //                   )
  //                 )
  //               )
  //             ]
  //           )
  //       ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Status da proposição"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Ano'),
              subtitle: Text((_project?.ano.toString() == '0' ? DateTime.now().year.toString() : _project?.ano.toString()) ?? '2024'),
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
        ),
      ),
    );
  }
}