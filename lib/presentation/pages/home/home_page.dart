import 'package:flutter/material.dart';
import 'package:site_grupo_rmts/widgets/contato_section.dart';
import 'package:site_grupo_rmts/widgets/empresas_section.dart';
import 'package:site_grupo_rmts/widgets/footer_cta.dart';
import 'package:site_grupo_rmts/widgets/header.dart';
import 'package:site_grupo_rmts/widgets/hero_section.dart';
import 'package:site_grupo_rmts/widgets/localizacao_section.dart';
import 'package:site_grupo_rmts/widgets/missao_visao_section.dart';
import 'package:site_grupo_rmts/widgets/por_que_section.dart';
import 'package:site_grupo_rmts/widgets/quem_somos_section.dart';
import 'package:site_grupo_rmts/widgets/trabalhe_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _quemSomosKey = GlobalKey();
  final GlobalKey _empresasKey = GlobalKey();
  final GlobalKey _clientesKey = GlobalKey(); // se quiser uma seção depois
  final GlobalKey _trabalheKey = GlobalKey();
  final GlobalKey _localizacaoKey = GlobalKey();
  final GlobalKey _contatoKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
    _scrollController.animateTo(
      _scrollController.offset + offset.dy - 80, // 80 ~ altura do header
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(
            onQuemSomosTap: () => _scrollTo(_quemSomosKey),
            onEmpresasTap: () => _scrollTo(_empresasKey),
            onClientesTap: () => _scrollTo(_clientesKey),
            onTrabalheTap: () => _scrollTo(_trabalheKey),
            onLocalizacaoTap: () => _scrollTo(_localizacaoKey),
            onContatoTap: () => _scrollTo(_contatoKey),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const HeroSection(),
                  QuemSomosSection(key: _quemSomosKey),
                  EmpresasSection(key: _empresasKey),
                  PorQueSection(key: _clientesKey),
                  LocalizacaoSection(key: _localizacaoKey),
                  MissaoVisaoSection(),
                  TrabalheSection(key: _trabalheKey),
                  ContatoSection(key: _contatoKey),
                  const FooterCTA(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
