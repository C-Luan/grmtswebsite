import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/contracheque_model.dart';
import 'package:intl/intl.dart';
import '../colaborador_viewer_page.dart';

class ContrachequeCard extends StatelessWidget {
  final ContrachequeModel contracheque;
  final VoidCallback onUpdate;

  const ContrachequeCard({
    super.key,
    required this.contracheque,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: contracheque.abertoEm == null
              ? AppColors.redMts.withOpacity(0.3)
              : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${contracheque.mesExtenso} ${contracheque.ano}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (contracheque.abertoEm == null)
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatus(
            Icons.cloud_upload_outlined,
            'Enviado em: ${contracheque.uploadadoEm != null ? dateFormat.format(contracheque.uploadadoEm!) : 'N/A'}',
            Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          _buildStatus(
            Icons.visibility_outlined,
            contracheque.abertoEm != null
                ? 'Aberto em: ${dateFormat.format(contracheque.abertoEm!)}'
                : 'Não aberto',
            contracheque.abertoEm != null
                ? Colors.blue.withOpacity(0.8)
                : Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 8),
          _buildStatus(
            Icons.check_circle_outline,
            contracheque.assinado
                ? 'Assinado em: ${contracheque.assinadoEm != null ? dateFormat.format(contracheque.assinadoEm!) : 'Sim'}'
                : 'Pendente de assinatura',
            contracheque.assinado
                ? Colors.green.withOpacity(0.8)
                : Colors.orange.withOpacity(0.8),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ColaboradorViewerPage(contracheque: contracheque),
                      ),
                    );
                    if (result == true) {
                      onUpdate();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('VISUALIZAR'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Download
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redMts,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'BAIXAR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatus(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }
}
