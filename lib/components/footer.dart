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
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 24 : 30,
        horizontal: isMobile ? 20 : 120,
      ),
      child: isMobile ? _mobileLayout() : _desktopLayout(),
    );
  }

  Widget _desktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _copyrightText(),
        _linksRow(),
      ],
    );
  }

  Widget _mobileLayout() {
    return Column(
      children: [
        _copyrightText(),
        const SizedBox(height: 14),
        _linksRow(),
      ],
    );
  }

  Widget _copyrightText() => const Text(
        '© Grupo RMTS • Todos os direitos reservados',
        style: TextStyle(
          color: AppColors.lightBackground,
          fontSize: 14,
        ),
      );

  Widget _linksRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FooterLink(
            text: 'Fale comigo no WhatsApp',
            onTap: _launchWhatsApp,
          ),
          const SizedBox(width: 20),
          _FooterLink(
            text: 'Desenvolvido por @_c.luan',
            onTap: _launchLinktree,
          ),
        ],
      );
}

/// 🔗 Link com hover elegante (Web/Desktop)
class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({
    required this.text,
    required this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: _hovering
              ? AppColors.accentRed // destaque no hover
              : AppColors.lightText,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w600,
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
