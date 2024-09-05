import 'package:legistrack/models/status_proposicao.dart';

class Project {
  final int id;
  final String uri;
  final String siglaTipo;
  final int codTipo;
  final int numero;
  final int ano;
  final String ementa;
  final StatusProposicao? statusProposicao;

  Project({
    required this.id,
    required this.uri,
    required this.siglaTipo,
    required this.codTipo,
    required this.numero,
    required this.ano,
    required this.ementa,
    required this.statusProposicao
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      uri: json['uri'],
      siglaTipo: json['siglaTipo'],
      codTipo: json['codTipo'],
      numero: json['numero'],
      ano: json['ano'],
      ementa: json['ementa'],
      statusProposicao: json['statusProposicao'] != null
      ? StatusProposicao.fromJson(json['statusProposicao'])
      : null
    );
  }
}