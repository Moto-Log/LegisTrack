class Project {
  final int id;
  final String uri;
  final String siglaTipo;
  final int codTipo;
  final int numero;
  final int ano;
  final String ementa;

  Project({
    required this.id,
    required this.uri,
    required this.siglaTipo,
    required this.codTipo,
    required this.numero,
    required this.ano,
    required this.ementa
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      uri: json['uri'],
      siglaTipo: json['siglaTipo'],
      codTipo: json['codTipo'],
      numero: json['numero'],
      ano: json['ano'],
      ementa: json['ementa']
    );
  }
}