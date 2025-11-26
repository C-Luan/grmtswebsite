import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class PorQueSection extends StatelessWidget {
  const PorQueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final itens = [
      'Equipes treinadas e certificadas',
      'Monitoramento digital e gestão integrada',
      'Planejamento estratégico, tático e operacional',
      'Consultoria de Segurança',
      'Somos uma empresa compliance',
      'Comprometimento com ESG',
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 24 : 80,
      ),
      child: Column(
        children: [
          const Text(
            'POR QUE NOS CONTRATAR:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 24,
            children: itens
                .map(
                  (t) => SizedBox(
                    width: isMobile ? double.infinity : 220,
                    child: _FeatureItem(title: t),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String title;
  const _FeatureItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // aqui você pode usar seu próprio ícone vermelho
        const Icon(Icons.verified, color: AppColors.accentRed, size: 40),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 1.3,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }
}
