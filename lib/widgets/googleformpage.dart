import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleFormPage extends StatefulWidget {
  const GoogleFormPage({super.key});

  @override
  State<GoogleFormPage> createState() => _GoogleFormPageState();
}

class _GoogleFormPageState extends State<GoogleFormPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          'https://docs.google.com/forms/d/e/1FAIpQLSe7F7A-cHyCBF4OjZ4WQpgHp3JID79C-1GZNYsUfLaG9tzKsA/viewform',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Currículo'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
