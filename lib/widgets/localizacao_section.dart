import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class LocalizacaoSection extends StatelessWidget {
  const LocalizacaoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.lightBackground,
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
                  'NOSSA LOCALIZAÇÃO',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Tv. Pirajá, 1954 - Marco, Belém - PA, 66095-631',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40, height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/fachada_rmts.png',
                height: 480,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
