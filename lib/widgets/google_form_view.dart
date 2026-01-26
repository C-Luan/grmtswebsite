import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// ✅ IMPORT CORRETO PARA FLUTTER WEB
import 'dart:ui_web' as ui;

class GoogleFormView extends StatelessWidget {
  GoogleFormView({super.key});

  static const String formUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSe7F7A-cHyCBF4OjZ4WQpgHp3JID79C-1GZNYsUfLaG9tzKsA/viewform?embedded=true';

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Center(child: CircularProgressIndicator());
    }

    // registra o iframe
    ui.platformViewRegistry.registerViewFactory(
      'google-form-iframe',
      (int viewId) {
        final iframe = html.IFrameElement()
          ..src = formUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';

        return iframe;
      },
    );

    return const HtmlElementView(viewType: 'google-form-iframe');
  }
}
