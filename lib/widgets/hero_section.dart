import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 24 : 80,
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text(
                  'GRUPO RMTS',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Especialistas em Segurança,\nServiços e Conformidade',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32,
                    height: 1.2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: AppColors.accentRed,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Atendemos em todo o Pará com excelência e agilidade.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // você pode linkar com a seção de contato se quiser
                  },
                  child: const Text('SOLICITE SEU ORÇAMENTO'),
                )
              ],
            ),
          ),
          const SizedBox(width: 40, height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/seguranca_hero.png',
                height: isMobile ? 260 : 380,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
