class StatusProposicao {
      final int     sequencia;
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
    required this.siglaOrgao,
    required this.uriOrgao,
    required this.uriUltimoRelator,
    required this.regime,
    required this.descricaoTramitacao,
    required this.codTipoTramitacao,
    required this.descricaoSituacao,
    required this.codSituacao,
    required this.despacho,
    required this.url,
    required this.ambito,
    required this.apreciacao
  });

   factory StatusProposicao.fromJson(Map<String, dynamic> json) {
    return StatusProposicao(
      sequencia: json['sequencia'],
      siglaOrgao: json['siglaOrgao'],
      uriOrgao: json['uriOrgao'],
      uriUltimoRelator: json['uriUltimoRelator'],
      regime: json['regime'],
      descricaoTramitacao: json['descricaoTramitacao'],
      codTipoTramitacao: json['codTipoTramitacao'],
      descricaoSituacao: json['descricaoSituacao'],
      codSituacao: json['codSituacao'],
      despacho: json['despacho'],
      url: json['url'],
      ambito: json['ambito'],
      apreciacao: json['apreciacao']
    );
  }
}