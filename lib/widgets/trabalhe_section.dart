import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class TrabalheSection extends StatelessWidget {
  const TrabalheSection({super.key});

  void _openForm() {
    final uri = Uri.parse('https://forms.gle/z2BznGDvkgoyBEw87');
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 24 : 80,
      ),
      child: isMobile ? _buildMobile() : _buildDesktop(),
    );
  }

  /// ---------------- MOBILE ----------------
  Widget _buildMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'CADASTRE O SEU\nCURRÍCULO AQUI!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        _InfoMessage(),
        const SizedBox(height: 8),

        /// CTA PRINCIPAL
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _openForm,
            icon: const Icon(Icons.cloud_upload_outlined),
            label: const Text(
              'ENVIAR CURRÍCULO AGORA',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentRed,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Leva menos de 1 minuto',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),

    
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/trabalhe_conosco.png',
            height: 220,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  /// ---------------- DESKTOP ----------------
  Widget _buildDesktop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CADASTRE O SEU\nCURRÍCULO AQUI!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              _InfoMessage(),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _openForm,
                icon: const Icon(Icons.cloud_upload_outlined),
                label: const Text(
                  'ENVIAR CURRÍCULO AGORA',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentRed,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Leva menos de 1 minuto',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),

           
            ],
          ),
        ),

        const SizedBox(width: 40),

        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/trabalhe_conosco.png',
                  height: 360,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _openForm,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Cadastrar Currículo'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// -------- Mensagem institucional reutilizável --------
class _InfoMessage extends StatelessWidget {
  const _InfoMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: const [
          Icon(Icons.info_outline, size: 18, color: AppColors.primaryBlue),
          Text(
            'Importante: Para garantir a correta análise do seu perfil, '
            'aceitamos currículos exclusivamente pelo formulário online. '
            'Não realizamos recebimento por WhatsApp, e-mail, telefone ou presencialmente.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
