class Project {
  final int id;
  final String siglaTipo;
  final String numero;
  final String ano;
  final String ementa;
  final String apelido;
  final String uri;
  final String uriDetalhe;
  final String uriAutoria;
  final String uriTramitacao;
  final String uriVotacao;
  final String uriAvaliacao;
  final String uriDocumento;
  final String palavrasChave;
  final String assunto;
  final String situacao;
  final String uriSituacao;
  final String dataSituacao;
  final String parecer;
  final String uriParecer;
  final String dataParecer;
  final String dataPublicacao;
  final String dataRecebimento;
  final String dataEntrada;
  final String dataPrevista;
  final String dataUltimaAlteracao;

  Project({
    required this.id,
    required this.siglaTipo,
    required this.numero,
    required this.ano,
    required this.ementa,
    required this.apelido,
    required this.uri,
    required this.uriDetalhe,
    required this.uriAutoria,
    required this.uriTramitacao,
    required this.uriVotacao,
    required this.uriAvaliacao,
    required this.uriDocumento,
    required this.palavrasChave,
    required this.assunto,
    required this.situacao,
    required this.uriSituacao,
    required this.dataSituacao,
    required this.parecer,
    required this.uriParecer,
    required this.dataParecer,
    required this.dataPublicacao,
    required this.dataRecebimento,
    required this.dataEntrada,
    required this.dataPrevista,
    required this.dataUltimaAlteracao,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      siglaTipo: json['siglaTipo'],
      numero: json['numero'],
      ano: json['ano'],
      ementa: json['ementa'],
      apelido: json['apelido'],
      uri: json['uri'],
      uriDetalhe: json['uriDetalhe'],
      uriAutoria: json['uriAutoria'],
      uriTramitacao: json['uriTramitacao'],
      uriVotacao: json['uriVotacao'],
      uriAvaliacao: json['uriAvaliacao'],
      uriDocumento: json['uriDocumento'],
      palavrasChave: json['palavrasChave'],
      assunto: json['assunto'],
      situacao: json['situacao'],
      uriSituacao: json['uriSituacao'],
      dataSituacao: json['dataSituacao'],
      parecer: json['parecer'],
      uriParecer: json['uriParecer'],
      dataParecer: json['dataParecer'],
      dataPublicacao: json['dataPublicacao'],
      dataRecebimento: json['dataRecebimento'],
      dataEntrada: json['dataEntrada'],
      dataPrevista: json['dataPrevista'],
      dataUltimaAlteracao: json['dataUltimaAlteracao'],
    );
  }
}