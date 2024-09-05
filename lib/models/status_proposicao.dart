class StatusProposicao {
  final int sequencia;
  final String? siglaOrgao;
  final String? uriOrgao;
  final String? uriUltimoRelator;
  final String? regime;
  final String? descricaoTramitacao;
  final String? codTipoTramitacao;
  final String? descricaoSituacao;
  final String? codSituacao;
  final String? despacho;
  final String? url;
  final String? ambito;
  final String? apreciacao;

  StatusProposicao({
    required this.sequencia,
    this.siglaOrgao,
    this.uriOrgao,
    this.uriUltimoRelator,
    this.regime,
    this.descricaoTramitacao,
    this.codTipoTramitacao,
    this.descricaoSituacao,
    this.codSituacao,
    this.despacho,
    this.url,
    this.ambito,
    this.apreciacao,
  });

  factory StatusProposicao.fromJson(Map<String, dynamic> json) {
    return StatusProposicao(
      sequencia: json['sequencia'] ?? 0,
      siglaOrgao: json['siglaOrgao']?.toString() ?? '', // Garantir String
      uriOrgao: json['uriOrgao']?.toString() ?? '',     // Garantir String
      uriUltimoRelator: json['uriUltimoRelator']?.toString() ?? '', // Garantir String
      regime: json['regime']?.toString() ?? '',         // Garantir String
      descricaoTramitacao: json['descricaoTramitacao']?.toString() ?? '', // Garantir String
      codTipoTramitacao: json['codTipoTramitacao']?.toString() ?? '', // Garantir String
      descricaoSituacao: json['descricaoSituacao']?.toString() ?? '', // Garantir String
      codSituacao: json['codSituacao']?.toString() ?? '', // Garantir String
      despacho: json['despacho']?.toString() ?? '',       // Garantir String
      url: json['url']?.toString() ?? '',                 // Garantir String
      ambito: json['ambito']?.toString() ?? '',           // Garantir String
      apreciacao: json['apreciacao']?.toString() ?? '',   // Garantir String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sequencia': sequencia,
      'siglaOrgao': siglaOrgao,
      'uriOrgao': uriOrgao,
      'uriUltimoRelator': uriUltimoRelator,
      'regime': regime,
      'descricaoTramitacao': descricaoTramitacao,
      'codTipoTramitacao': codTipoTramitacao,
      'descricaoSituacao': descricaoSituacao,
      'codSituacao': codSituacao,
      'despacho': despacho,
      'url': url,
      'ambito': ambito,
      'apreciacao': apreciacao,
    };
  }
}
