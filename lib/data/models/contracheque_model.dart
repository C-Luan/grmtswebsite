class ContrachequeModel {
  final String uuid;
  final int ano;
  final int mes;
  final DateTime? uploadadoEm;
  final DateTime? abertoEm;
  final bool assinado;
  final DateTime? assinadoEm;

  ContrachequeModel({
    required this.uuid,
    required this.ano,
    required this.mes,
    this.uploadadoEm,
    this.abertoEm,
    this.assinado = false,
    this.assinadoEm,
  });

  factory ContrachequeModel.fromJson(Map<String, dynamic> json) {
    return ContrachequeModel(
      uuid: json['uuid'] ?? '',
      ano: json['ano'] ?? DateTime.now().year,
      mes: json['mes'] ?? DateTime.now().month,
      uploadadoEm: json['uploadado_em'] != null 
          ? DateTime.tryParse(json['uploadado_em']) 
          : null,
      abertoEm: json['aberto_em'] != null 
          ? DateTime.tryParse(json['aberto_em']) 
          : null,
      assinado: json['assinado'] ?? false,
      assinadoEm: json['assinado_em'] != null 
          ? DateTime.tryParse(json['assinado_em']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'ano': ano,
      'mes': mes,
      'uploadado_em': uploadadoEm?.toIso8601String(),
      'aberto_em': abertoEm?.toIso8601String(),
      'assinado': assinado,
      'assinado_em': assinadoEm?.toIso8601String(),
    };
  }

  String get mesExtenso {
    const meses = [
      '', 'JANEIRO', 'FEVEREIRO', 'MARÇO', 'ABRIL', 'MAIO', 'JUNHO',
      'JULHO', 'AGOSTO', 'SETEMBRO', 'OUTUBRO', 'NOVEMBRO', 'DEZEMBRO'
    ];
    if (mes >= 1 && mes <= 12) return meses[mes];
    return '';
  }
}
