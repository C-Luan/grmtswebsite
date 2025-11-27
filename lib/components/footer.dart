import 'package:flutter/material.dart';
import 'package:site_grupo_rmts/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchLinktree() async {
    const url = 'https://linktr.ee/_c.luan';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchWhatsApp() async {
    const phoneNumber = '5591985320555';
    final uri = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 24 : 30,
        horizontal: isMobile ? 20 : 120,
      ),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
        children: [
          if (!isMobile)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _copyrightText(),
                _linksRow(),
              ],
            )
          else
            Column(
              children: [
                _copyrightText(),
                const SizedBox(height: 14),
                _linksRow(),
              ],
            ),
        ],
      ),
    );
  }

  Widget _copyrightText() => const Text(
        '© Vega Facilities • Todos os direitos reservados',
        style: TextStyle(color: AppColors.darkText, fontSize: 14),
      );

  Widget _linksRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _launchWhatsApp,
            child: const Text(
              'Fale comigo no WhatsApp',
              style: TextStyle(
                color: AppColors.lightText,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: _launchLinktree,
            child: const Text(
              'Desenvolvido por @_c.luan',
              style: TextStyle(
                color: AppColors.lightText,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
}
