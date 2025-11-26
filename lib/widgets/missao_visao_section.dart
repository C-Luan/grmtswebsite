import 'package:flutter/material.dart';
import '../../core/responsive.dart';

class MissaoVisaoSection extends StatelessWidget {
  const MissaoVisaoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final itens = [
      'assets/images/missao.png',
      'assets/images/visao.png',
      'assets/images/valores.png',
      'assets/images/inovacao.png',
      'assets/images/foco_cliente.png',
      'assets/images/responsabilidade.png',
    ];

    return Container(
      color: const Color(0xFF061733), // fundo azul igual ao PDF
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 80,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        runSpacing: 20,
        children: itens
            .map(
              (img) => _MVVCard(imagePath: img),
            )
            .toList(),
      ),
    );
  }
}

class _MVVCard extends StatelessWidget {
  final String imagePath;

  const _MVVCard({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SizedBox(
      width: isMobile ? double.infinity : 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
