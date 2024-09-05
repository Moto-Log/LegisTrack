import 'package:legistrack/models/status_proposicao.dart';

class Project {
  final int id;
  final String siglaTipo;
  final String numero;
  final String ano;
  final String ementa;
  final String apelido;
  final StatusProposicao? statusProposicao;

  Project({
    required this.id,
    required this.siglaTipo,
    required this.numero,
    required this.ano,
    required this.ementa,
    required this.apelido,
    this.statusProposicao,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      siglaTipo: json['siglaTipo']?.toString() ?? '', // Garantir String
      numero: json['numero']?.toString() ?? '',       // Garantir String
      ano: json['ano']?.toString() ?? '',             // Garantir String
      ementa: json['ementa'] ?? '',
      apelido: json['apelido'] ?? '',
      statusProposicao: json['statusProposicao'] != null
          ? StatusProposicao.fromJson(json['statusProposicao'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'siglaTipo': siglaTipo,
      'numero': numero,
      'ano': ano,
      'ementa': ementa,
      'apelido': apelido,
      'statusProposicao': statusProposicao?.toJson(),
    };
  }
}
