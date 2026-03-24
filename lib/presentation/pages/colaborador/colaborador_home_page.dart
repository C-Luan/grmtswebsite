import 'package:flutter/material.dart';
import 'package:site_grupo_rmts/core/constants/app_colors.dart';
import 'package:site_grupo_rmts/data/models/contracheque_model.dart';
import 'package:site_grupo_rmts/services/contracheque/contracheque_service.dart';
import 'package:site_grupo_rmts/services/login/authentication_service.dart';
import 'widgets/contracheque_card.dart';

class ColaboradorHomePage extends StatefulWidget {
  const ColaboradorHomePage({super.key});

  @override
  State<ColaboradorHomePage> createState() => _ColaboradorHomePageState();
}

class _ColaboradorHomePageState extends State<ColaboradorHomePage> {
  final ContrachequeService _service = ContrachequeService();
  List<ContrachequeModel> _contracheques = [];
  List<ContrachequeModel> _filteredContracheques = [];
  bool _isLoading = true;
  int? _filterAno = DateTime.now().year;
  int? _filterMes;
  String? _filterStatus;
  int _selectedIndex = 0; // 0 = Meus Contracheques, 1 = Meus Dados

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await _service.listar();
      setState(() {
        _contracheques = data;
        _applyFilters();
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar contracheques: $e')),
        );
      }
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredContracheques = _contracheques.where((c) {
        final matchesAno = _filterAno == null || c.ano == _filterAno;
        final matchesMes = _filterMes == null || c.mes == _filterMes;
        final matchesStatus =
            _filterStatus == null ||
            (_filterStatus == 'Assinado' ? c.assinado : !c.assinado);
        return matchesAno && matchesMes && matchesStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = AuthenticationService.instance.usuarioLogado;
    final rUser = AuthenticationService.instance.user;

    final String nome =
        model?.colaborador?.nomeCompleto ??
        rUser?['nomeCompleto'] ??
        'Colaborador';
    final int id = model?.colaborador?.id ?? rUser?['id'] ?? 0;

    final isMobile = MediaQuery.of(context).size.width < 800;

    Widget bodyContent;
    if (_selectedIndex == 0) {
      bodyContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(nome, id, isMobile),

          // Filters
          _buildFilters(isMobile),

          // List
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.redMts),
                  )
                : _filteredContracheques.isEmpty
                ? Center(
                    child: Text(
                      'Nenhum contracheque encontrado',
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                  )
                : isMobile
                ? ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredContracheques.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return ContrachequeCard(
                        contracheque: _filteredContracheques[index],
                        onUpdate: _loadData,
                      );
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(32),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          childAspectRatio: 1.3,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                        ),
                    itemCount: _filteredContracheques.length,
                    itemBuilder: (context, index) {
                      return ContrachequeCard(
                        contracheque: _filteredContracheques[index],
                        onUpdate: _loadData,
                      );
                    },
                  ),
          ),
        ],
      );
    } else {
      bodyContent = _buildMeusDados(isMobile);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: isMobile
          ? AppBar(
              backgroundColor: const Color(0xFFFFFFFF),
              title: const Text('Área do Colaborador'),
              foregroundColor: Color(0xFF111827),
              elevation: 0,
            )
          : null,
      drawer: isMobile
          ? Drawer(child: _buildSidebar(context, nome, isMobile))
          : null,
      body: Row(
        children: [
          if (!isMobile) _buildSidebar(context, nome, isMobile),
          Expanded(child: bodyContent),
        ],
      ),
    );
  }

  Widget _buildMeusDados(bool isMobile) {
    final model = AuthenticationService.instance.usuarioLogado;
    final rawUser = AuthenticationService.instance.user;

    if (model == null || model.colaborador == null) {
      if (rawUser == null) {
        return const Center(
          child: Text(
            'Nenhum dado encontrado',
            style: TextStyle(color: Color(0xFF111827)),
          ),
        );
      }
    }

    final colab = model?.colaborador;
    final dados = colab?.dadosPessoais;
    final endereco = colab?.endereco;

    String? formatCpf(String? cpf) {
      if (cpf == null || cpf.isEmpty) return null;
      final numericCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      if (numericCpf.length == 11) {
        return '${numericCpf.substring(0, 3)}.${numericCpf.substring(3, 6)}.${numericCpf.substring(6, 9)}-${numericCpf.substring(9, 11)}';
      }
      return '$cpf (Inválido - Contate o RH)';
    }

    bool isCpfInvalid(String? cpf) {
      if (cpf == null || cpf.isEmpty) return true;
      final numericCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      return numericCpf.length != 11;
    }

    String? parseAddress() {
      if (endereco == null) return null;
      final parts =
          [
                endereco.endereco,
                endereco.numero,
                endereco.complemento,
                endereco.bairro,
                endereco.cidade,
                endereco.uf,
                endereco.cep,
              ]
              .where(
                (e) =>
                    e != null &&
                    e.trim().isNotEmpty &&
                    e.toUpperCase() != 'S/N' &&
                    e.toUpperCase() != 'SN',
              )
              .toList();

      return parts.isEmpty ? null : parts.join(', ');
    }

    String? formatDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return null;
      try {
        final date = DateTime.parse(dateStr);
        return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
      } catch (e) {
        return dateStr;
      }
    }

    final rawCpf = dados?.cpf ?? rawUser?['cpf'];

    final fields = [
      {
        'label': 'Nome Completo',
        'value': colab?.nomeCompleto ?? rawUser?['nomeCompleto'],
      },
      {
        'label': 'CPF',
        'value': formatCpf(rawCpf),
        'isError': isCpfInvalid(rawCpf),
      },
      {'label': 'RG', 'value': dados?.rg ?? rawUser?['rg']},
      {'label': 'E-mail', 'value': rawUser?['email']},
      {'label': 'Telefone', 'value': rawUser?['telefone']},
      {
        'label': 'Data de Nascimento',
        'value': formatDate(colab?.nascimento) ?? rawUser?['dataNascimento'],
      },
      {'label': 'Cargo', 'value': colab?.funcao ?? rawUser?['cargo']},
      {'label': 'Setor', 'value': colab?.setor ?? rawUser?['setor']},
      {'label': 'CTPS', 'value': dados?.ctps},
      {'label': 'PIS/PASEP', 'value': dados?.pis},
      {'label': 'CNH', 'value': dados?.cnh},
      {'label': 'Estado Civil', 'value': dados?.estadoCivil},
      {
        'label': 'Endereço Completo',
        'value': parseAddress() ?? rawUser?['endereco'],
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meus Dados',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 32),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isMobile ? 16 : 32),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withOpacity(0.1)),
            ),
            child: Wrap(
              spacing: isMobile ? 16 : 32,
              runSpacing: isMobile ? 16 : 32,
              children: fields
                  .map((f) {
                    if (f['value'] == null || f['value'].toString().isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return SizedBox(
                      width: isMobile ? double.infinity : 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            f['label']!.toString().toUpperCase(),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            f['value'].toString(),
                            style: TextStyle(
                              color: f['isError'] == true
                                  ? Colors.redAccent
                                  : Color(0xFF111827),
                              fontSize: 16,
                              fontWeight: f['isError'] == true
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                  .toList()
                  .where((w) => w.width != 0.0)
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, String nome, bool isMobile) {
    return Container(
      width: 280,
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          const SizedBox(height: 48),
          const Icon(Icons.shield, color: AppColors.redMts, size: 40),
          const SizedBox(height: 12),
          const Text(
            'GRUPO RMTS',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 48),
          _buildMenuItem(
            0,
            Icons.description_outlined,
            'Meus Contracheques',
            isMobile,
          ),
          _buildMenuItem(1, Icons.person_outline, 'Meus Dados', isMobile),
          _buildMenuItem(2, Icons.security_outlined, 'Segurança', isMobile),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.redMts.withOpacity(0.2),
                  child: Text(
                    nome[0],
                    style: const TextStyle(color: AppColors.redMts),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        nome,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Colaborador',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await AuthenticationService.instance.logout();
                    if (mounted) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/colaborador/login',
                      );
                    }
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black.withOpacity(0.3),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String label, bool isMobile) {
    final active = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: active ? AppColors.redMts.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: active ? AppColors.redMts : Colors.black.withOpacity(0.6),
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: active ? Color(0xFF111827) : Colors.black.withOpacity(0.6),
            fontSize: 14,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (index == 2)
            return; // Ignore Segurança for now if not implemented.
          setState(() {
            _selectedIndex = index;
          });
          if (isMobile) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _buildHeader(String nome, int id, bool isMobile) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 16 : 32,
        isMobile ? 24 : 48,
        isMobile ? 16 : 32,
        isMobile ? 16 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meus Contracheques',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Olá, $nome',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.redMts.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.redMts.withOpacity(0.3)),
                ),
                child: Text(
                  'ID: #$id',
                  style: const TextStyle(
                    color: AppColors.redMts,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(bool isMobile) {
    final meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    final years = [for (var i = 2023; i <= DateTime.now().year + 2; i++) i];

    final anoWidget = _buildDropdown<int>(
      value: _filterAno,
      hint: 'Ano',
      items: [
        const DropdownMenuItem(value: null, child: Text('Todos os Anos')),
        ...years.map((y) => DropdownMenuItem(value: y, child: Text('Ano: $y'))),
      ],
      onChanged: (v) {
        setState(() => _filterAno = v);
        _applyFilters();
      },
    );

    final mesWidget = _buildDropdown<int>(
      value: _filterMes,
      hint: 'Mês',
      items: [
        const DropdownMenuItem(value: null, child: Text('Todos os Meses')),
        ...meses.asMap().entries.map(
          (e) => DropdownMenuItem(
            value: e.key + 1,
            child: Text('Mês: ${e.value}'),
          ),
        ),
      ],
      onChanged: (v) {
        setState(() => _filterMes = v);
        _applyFilters();
      },
    );

    final statusWidget = _buildDropdown<String>(
      value: _filterStatus,
      hint: 'Status',
      items: const [
        DropdownMenuItem(value: null, child: Text('Status: Todos')),
        DropdownMenuItem(value: 'Assinado', child: Text('Status: Assinado')),
        DropdownMenuItem(value: 'Pendente', child: Text('Status: Pendente')),
      ],
      onChanged: (v) {
        setState(() => _filterStatus = v);
        _applyFilters();
      },
    );

    final buscarWidget = GestureDetector(
      onTap: _applyFilters,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.redMts,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 16, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'BUSCAR',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      child: isMobile
          ? Wrap(
              spacing: 8,
              runSpacing: 12,
              children: [anoWidget, mesWidget, statusWidget, buscarWidget],
            )
          : Row(
              children: [
                anoWidget,
                const SizedBox(width: 12),
                mesWidget,
                const SizedBox(width: 12),
                statusWidget,
                const Spacer(),
                buscarWidget,
              ],
            ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T?>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T?>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 13,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Colors.black.withOpacity(0.4),
          ),
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
