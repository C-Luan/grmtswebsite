import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:site_grupo_rmts/core/constants/app_colors.dart';
import 'package:site_grupo_rmts/data/models/contracheque_model.dart';
import 'package:site_grupo_rmts/services/contracheque/contracheque_service.dart';
import 'package:site_grupo_rmts/services/login/authentication_service.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui_web' as ui;
import 'widgets/assinatura_dialog.dart';

class ColaboradorViewerPage extends StatefulWidget {
  final ContrachequeModel contracheque;

  const ColaboradorViewerPage({super.key, required this.contracheque});

  @override
  State<ColaboradorViewerPage> createState() => _ColaboradorViewerPageState();
}

class _ColaboradorViewerPageState extends State<ColaboradorViewerPage> {
  final ContrachequeService _service = ContrachequeService();
  late String _viewId;
  bool _isSigning = false;
  bool _showIframe = true;

  @override
  void initState() {
    super.initState();
    _viewId = 'pdf-viewer-${widget.contracheque.uuid}';
    final token = AuthenticationService.instance.accessToken ?? '';
    final url = _service.getPdfUrl(widget.contracheque.uuid, token);

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) => html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );
  }

  Future<void> _handleAssinar() async {
    setState(() => _showIframe = false);

    await showDialog(
      context: context,
      builder: (context) => AssinaturaDialog(
        titulo: '${widget.contracheque.mesExtenso} ${widget.contracheque.ano}',
        onConfirm: (bytes) async {
          Navigator.pop(context);
          setState(() => _isSigning = true);
          try {
            final base64String = base64Encode(bytes);
            await _service.assinar(widget.contracheque.uuid, base64String);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contracheque assinado com sucesso!'),
                ),
              );
              Navigator.pop(
                context,
                true,
              ); // Retorna true para atualizar a lista
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Erro ao assinar: $e')));
            }
          } finally {
            if (mounted) setState(() => _isSigning = false);
          }
        },
      ),
    );

    if (mounted) {
      setState(() => _showIframe = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: Text(
          '${widget.contracheque.mesExtenso} ${widget.contracheque.ano}',
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF111827),
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () {
              final token = AuthenticationService.instance.accessToken ?? '';
              final url = _service.getPdfUrl(widget.contracheque.uuid, token);
              html.window.open(url, '_blank');
            },
            tooltip: 'Baixar PDF',
          ),
          const SizedBox(width: 8),
          if (!widget.contracheque.assinado)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: _isSigning ? null : _handleAssinar,
                icon: const Icon(Icons.border_color, size: 18),
                label: const Text('ASSINAR'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redMts,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
              ),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: _isSigning
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.redMts),
            )
          : Offstage(
              offstage: !_showIframe,
              child: HtmlElementView(viewType: _viewId),
            ),
    );
  }
}
