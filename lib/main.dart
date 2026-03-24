import 'dart:ui';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/colaborador/colaborador_login_page.dart';
import 'presentation/pages/colaborador/colaborador_home_page.dart';

import 'package:site_grupo_rmts/utils/api_client.dart';
import 'package:site_grupo_rmts/services/login/authentication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa interceptores
  ApiClient.setup();
  
  // Carrega sessão salva
  await AuthenticationService.instance.init();
  
  runApp(const RMTSApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

class RMTSApp extends StatelessWidget {
  const RMTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grupo RMTS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/colaborador/login': (context) => const ColaboradorLoginPage(),
        '/colaborador/home': (context) => const ColaboradorHomePage(),
      },
    );
  }
}
