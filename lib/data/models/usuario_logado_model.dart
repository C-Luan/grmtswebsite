class UsuarioLogadoModel {
  final String? uuid;
  final bool? isAtivo;
  final String? createdAt;
  final String? updatedAt;
  final int? perfil;
  final PerfilModel? perfilObj;
  final ColaboradorLogadoModel? colaborador;

  UsuarioLogadoModel({
    this.uuid,
    this.isAtivo,
    this.createdAt,
    this.updatedAt,
    this.perfil,
    this.perfilObj,
    this.colaborador,
  });

  factory UsuarioLogadoModel.fromJson(Map<String, dynamic> json) {
    return UsuarioLogadoModel(
      uuid: json['uuid']?.toString(),
      isAtivo: json['isAtivo'] as bool?,
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      perfil: json['perfil'] is int
          ? json['perfil']
          : int.tryParse(json['perfil']?.toString() ?? ''),
      perfilObj:
          json['Perfil'] != null ? PerfilModel.fromJson(json['Perfil']) : null,
      colaborador: json['colaborador'] != null
          ? ColaboradorLogadoModel.fromJson(json['colaborador'])
          : null,
    );
  }
}

class PerfilModel {
  final int? id;
  final String? descricao;

  PerfilModel({this.id, this.descricao});

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      descricao: json['descricao']?.toString(),
    );
  }
}

class ColaboradorLogadoModel {
  final int? id;
  final String? nomeCompleto;
  final String? nascimento;
  final String? funcao;
  final String? setor;
  final EmpresaModel? empresa;
  final DadosPessoaisModel? dadosPessoais;
  final EnderecoColaboradorModel? endereco;

  ColaboradorLogadoModel({
    this.id,
    this.nomeCompleto,
    this.nascimento,
    this.funcao,
    this.setor,
    this.empresa,
    this.dadosPessoais,
    this.endereco,
  });

  factory ColaboradorLogadoModel.fromJson(Map<String, dynamic> json) {
    return ColaboradorLogadoModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      nomeCompleto: json['nomeCompleto']?.toString(),
      nascimento: json['nascimento']?.toString(),
      funcao: json['funcao']?.toString(),
      setor: json['setor']?.toString(),
      empresa: json['Empresa'] != null
          ? EmpresaModel.fromJson(json['Empresa'])
          : null,
      dadosPessoais: json['dadosPessoais'] != null
          ? DadosPessoaisModel.fromJson(json['dadosPessoais'])
          : null,
      endereco: json['EnderecoColaborador'] != null
          ? EnderecoColaboradorModel.fromJson(json['EnderecoColaborador'])
          : null,
    );
  }
}

class EmpresaModel {
  final int? id;
  final String? nomeEmpresa;
  final String? cnpj;

  EmpresaModel({this.id, this.nomeEmpresa, this.cnpj});

  factory EmpresaModel.fromJson(Map<String, dynamic> json) {
    return EmpresaModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      nomeEmpresa: json['nomeEmpresa']?.toString(),
      cnpj: json['cnpj']?.toString(),
    );
  }
}

class DadosPessoaisModel {
  final String? cpf;
  final String? rg;
  final String? cnh;
  final String? ctps;
  final String? pis;
  final String? estadoCivil;

  DadosPessoaisModel({
    this.cpf,
    this.rg,
    this.cnh,
    this.ctps,
    this.pis,
    this.estadoCivil,
  });

  factory DadosPessoaisModel.fromJson(Map<String, dynamic> json) {
    return DadosPessoaisModel(
      cpf: json['cpf']?.toString(),
      rg: json['rg']?.toString(),
      cnh: json['cnh']?.toString(),
      ctps: json['ctps']?.toString(),
      pis: json['pis']?.toString(),
      estadoCivil: json['estadoCivil']?.toString(),
    );
  }
}

class EnderecoColaboradorModel {
  final String? endereco;
  final String? numero;
  final String? complemento;
  final String? cep;
  final String? cidade;
  final String? uf;
  final String? bairro;

  EnderecoColaboradorModel({
    this.endereco,
    this.numero,
    this.complemento,
    this.cep,
    this.cidade,
    this.uf,
    this.bairro,
  });

  factory EnderecoColaboradorModel.fromJson(Map<String, dynamic> json) {
    return EnderecoColaboradorModel(
      endereco: json['endereco']?.toString(),
      numero: json['numero']?.toString(),
      complemento: json['complemento']?.toString(),
      cep: json['cep']?.toString(),
      cidade: json['cidade']?.toString(),
      uf: json['uf']?.toString(),
      bairro: json['bairro']?.toString(),
    );
  }
}
