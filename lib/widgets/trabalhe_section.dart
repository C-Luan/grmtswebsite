import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class TrabalheSection extends StatelessWidget {
  const TrabalheSection({super.key});

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
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment:
                  isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: const [
                Text(
                  'CADASTRE O SEU\nCURRÍCULO AQUI!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'No campo de observações, adicione o texto "Escolta Armada".',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkText,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(width: 40, height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 ClipRRect(
                   borderRadius: BorderRadius.circular(20),
                   child: Image.asset(
                     'assets/images/trabalhe_conosco.png',
                     height: 360,
                     fit: BoxFit.cover,
                   ),
                 ),
                ElevatedButton.icon(
                  onPressed: () {
                    // abrir link de formulário (URL launcher no mobile/web)
                  },
                  icon: const Icon(Icons.cloud_upload_outlined),
                  label: const Text('Cadastrar Currículo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
