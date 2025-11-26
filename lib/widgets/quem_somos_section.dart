import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class QuemSomosSection extends StatelessWidget {
  const QuemSomosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 24 : 80,
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: const [
                Text(
                  'QUEM SOMOS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'O Grupo RMTS é um conglomerado especializado em soluções '
                  'integradas de segurança e facilities, atuando com excelência, '
                  'conformidade e foco absoluto na eficiência operacional. '
                  'Reunimos empresas complementares que, juntas, oferecem uma '
                  'gestão completa, segura e alinhada às melhores práticas de mercado.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.darkText,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Homologada pela Polícia Federal - Alvará nº 185/2021 | Certificado nº 2944/2021',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40, height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/images/equipe_multidisciplinar.png',
                height: 320,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
