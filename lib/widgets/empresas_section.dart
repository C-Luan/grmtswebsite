import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class EmpresasSection extends StatelessWidget {
  const EmpresasSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final cards = [
      _EmpresaCardData(
        logoPath: 'assets/logos/mts_seguranca.png',
        descricao:
            'Especializada em segurança patrimonial, com atuação pautada em conformidade, princípios ESG e cuidado humano, garantindo proteção estratégica e responsável.',
      ),
      _EmpresaCardData(
        logoPath: 'assets/logos/comply.png',
        descricao:
            'Unidade focada em terceirização com rigor em conformidade legal, ética e operacional, assegurando segurança jurídica e práticas responsáveis.',
      ),
      _EmpresaCardData(
        logoPath: 'assets/logos/rmts_servicos.png',
        descricao:
            'Responsável pela terceirização de serviços essenciais, como portaria, recepção, jardinagem, limpeza e apoio operacional, garantindo equipes qualificadas e processos eficientes.',
      ),
      // _EmpresaCardData(
      //   logoPath: 'assets/logos/jr_consult.png',
      //   descricao:
      //       'Empresa dedicada ao suporte e atendimento em operações aeroportuárias, com expertise em ambientes de alta criticidade e fluxo constante.',
      // ),
    ];

    return Container(
      color: AppColors.primaryBlue,
      width: double.infinity,
      height: 480,
      // padding: EdgeInsets.symmetric(
      //   vertical: isMobile ? 40 : 80,
      //   horizontal: isMobile ? 24 : 240,
      // ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 32,
          runSpacing: 32,
          children: cards
              .map(
                (c) => SizedBox(
                  width: isMobile ? double.infinity : 360,
                  child: _EmpresaCard(data: c),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _EmpresaCardData {
  final String logoPath;
  final String descricao;

  _EmpresaCardData({
    required this.logoPath,
    required this.descricao,
  });
}

class _EmpresaCard extends StatelessWidget {
  final _EmpresaCardData data;
  const _EmpresaCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              data.logoPath,
              height: 64,
            ),
            const SizedBox(height: 16),
            Text(
              data.descricao,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: AppColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
