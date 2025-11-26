import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class FooterCTA extends StatelessWidget {
  const FooterCTA({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 60,
        horizontal: isMobile ? 24 : 80,
      ),
      child: Column(
        children: [
          const Text(
            'Não pergunte se somos capazes,\n'
            'dê-nos a missão!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // pode rolar até contato
            },
            child: const Text('SOLICITE SEU ORÇAMENTO'),
          ),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} Grupo RMTS - Todos os direitos reservados.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
