import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home/home_page.dart';

void main() {
  runApp(const RMTSApp());
}

class RMTSApp extends StatelessWidget {
  const RMTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grupo RMTS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
