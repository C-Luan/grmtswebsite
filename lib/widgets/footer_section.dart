import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_grupo_rmts/components/footer.dart';
import 'package:site_grupo_rmts/core/constants/app_colors.dart';
import 'package:site_grupo_rmts/core/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class FoorterSection extends StatelessWidget {
  const FoorterSection({super.key});

  Future<void> _launchInstagram() async {
    final url = Uri.parse('https://www.instagram.com/mts.seguranca/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchWhatsApp() async {
    const phoneNumber = '5591985320555';
    final uri = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openMaps() async {
    final uri = Uri.parse(
      'https://maps.app.goo.gl/sDqmgqoi3imemD3G6',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sendEmail() async {
    final uri = Uri.parse('mailto:comercial@grupormts.com ');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 80 : 120,
            horizontal: isMobile ? 16 : 200,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _contactInfo(isMobile),
                    const SizedBox(height: 36),
                    Column(
                      children: [
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
                        _mapContainer(isMobile),
                      ],
                    ),
                  ],
                )
              : Row(
                spacing: 120,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        _mapContainer(isMobile),
                      ],
                    )),
                    // const SizedBox(width: 36),
                    Expanded(flex: 1, child: _contactInfo(isMobile)),
                  ],
                ),
        ),
        const Footer(),
      ],
    );
  }

  Widget _mapContainer(bool isMobile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: isMobile ? 450 : 450,
        child: WebViewX(
          initialContent: '''
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3988.5733226132047!2d-48.4540528!3d-1.4313856!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x92a464065f8f5189%3A0xf8fb9931733ae5a1!2sMts%20Seguran%C3%A7a%20Ltda!5e0!3m2!1spt-PT!2sbr!4v1764251043831!5m2!1spt-PT!2sbr" width="450" height="350" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
          ''',
          initialSourceType: SourceType.html,
          height: isMobile ? 450 : 450,
          width: 600,
        ),
      ),
    );
  }

  Widget _contactInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ENTRE EM CONTATO',
          style: TextStyle(
            fontSize: 22,

            fontWeight: FontWeight.bold,
            // color: AppColors.primary
          ),
        ),
        const SizedBox(height: 14),
        HoverContactItem(
          icon: FontAwesomeIcons.whatsapp,
          text: '+55 91 98532-0555',
          color: const Color(0xFF25D366),
          onTap: _launchWhatsApp,
        ),
        HoverContactItem(
          icon: FontAwesomeIcons.locationDot,
          text: 'Tv. Pirajá, 1954 - Marco',
          color: Colors.redAccent,
          onTap: _openMaps,
        ),
        HoverContactItem(
          icon: FontAwesomeIcons.envelope,
          text: 'comercial@grupormts.com',
          color: Colors.orangeAccent,
          onTap: _sendEmail,
        ),
        const SizedBox(height: 18),
        HoverContactItem(
          icon: FontAwesomeIcons.instagram,
          text: '@mts.seguranca',
          color: const Color(0xFFC13584),
          onTap: _launchInstagram,
        ),
      ],
    );
  }
}

class HoverContactItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const HoverContactItem({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  State<HoverContactItem> createState() => _HoverContactItemState();
}

class _HoverContactItemState extends State<HoverContactItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _hovering
              ? (Matrix4.identity()..scale(1.05))
              : Matrix4.identity(),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 28,
                child: FaIcon(
                  widget.icon,
                  color: _hovering
                      ? widget.color.withOpacity(0.9)
                      : widget.color.withOpacity(0.7),
                  size: _hovering ? 20 : 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 15,
                    // fontFamily: GoogleFonts.metrophobic().fontFamily,
                    color: _hovering
                        ? widget.color.withOpacity(0.9)
                        : Colors.black87,
                    fontWeight: _hovering ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
