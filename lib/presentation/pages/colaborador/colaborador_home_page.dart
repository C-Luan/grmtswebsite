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
  int? _filterAno = 2025;
  int? _filterMes;

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
        return matchesAno && matchesMes;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthenticationService.instance.user;
    final String nome = user?['nomeCompleto'] ?? 'Colaborador';
    final int id = user?['id'] ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1E),
      body: Row(
        children: [
          // Sidebar
          _buildSidebar(context, nome),

          // Main Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(nome, id),

                // Filters
                _buildFilters(),

                // List
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.redMts,
                          ),
                        )
                      : _filteredContracheques.isEmpty
                      ? Center(
                          child: Text(
                            'Nenhum contracheque encontrado',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(32),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 400,
                                childAspectRatio: 1.8,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, String nome) {
    return Container(
      width: 280,
      color: const Color(0xFF111827),
      child: Column(
        children: [
          const SizedBox(height: 48),
          const Icon(Icons.shield, color: AppColors.redMts, size: 40),
          const SizedBox(height: 12),
          const Text(
            'GRUPO RMTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 48),
          _buildMenuItem(
            Icons.description_outlined,
            'Meus Contracheques',
            true,
          ),
          _buildMenuItem(Icons.person_outline, 'Meus Dados', false),
          _buildMenuItem(Icons.security_outlined, 'Segurança', false),
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
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Colaborador',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await AuthenticationService.instance.logout();
                    if (mounted)
                      Navigator.pushReplacementNamed(
                        context,
                        '/colaborador/login',
                      );
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white.withOpacity(0.3),
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

  Widget _buildMenuItem(IconData icon, String label, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: active ? AppColors.redMts.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: active ? AppColors.redMts : Colors.white.withOpacity(0.6),
          size: 20,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.white.withOpacity(0.6),
            fontSize: 14,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildHeader(String nome, int id) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meus Contracheques',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Olá, $nome',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.redMts.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.redMts.withOpacity(0.3),
                      ),
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
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          _buildFilterPill('Ano: 2025'),
          const SizedBox(width: 12),
          _buildFilterPill('Mês: Todos'),
          const SizedBox(width: 12),
          _buildFilterPill('Status: Todos'),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.redMts,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, size: 18, color: Colors.black),
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
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: Colors.white.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
