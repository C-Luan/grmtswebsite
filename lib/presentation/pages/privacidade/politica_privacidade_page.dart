import 'package:flutter/material.dart';
import 'package:site_grupo_rmts/components/footer.dart';
import 'package:site_grupo_rmts/core/constants/app_colors.dart';
import 'package:site_grupo_rmts/core/responsive.dart';
import 'package:site_grupo_rmts/widgets/header.dart';

class PoliticaPrivacidadePage extends StatelessWidget {
  const PoliticaPrivacidadePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: Column(
        children: [
          Header(
            onQuemSomosTap: () => Navigator.pushNamed(context, '/'),
            onEmpresasTap: () => Navigator.pushNamed(context, '/'),
            onClientesTap: () => Navigator.pushNamed(context, '/'),
            onTrabalheTap: () => Navigator.pushNamed(context, '/'),
            onLocalizacaoTap: () => Navigator.pushNamed(context, '/'),
            onContatoTap: () => Navigator.pushNamed(context, '/'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _HeroBanner(isMobile: isMobile),
                  _ContentBody(isMobile: isMobile),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final bool isMobile;
  const _HeroBanner({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 72,
        horizontal: isMobile ? 24 : 200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AVISO DE PRIVACIDADE',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Última atualização: maio de 2025',
            style: TextStyle(
              fontSize: isMobile ? 13 : 15,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentBody extends StatelessWidget {
  final bool isMobile;
  const _ContentBody({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.lightBackground,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 72,
        horizontal: isMobile ? 24 : 200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: '1. Quem somos',
            body:
                'O Grupo RMTS, com sede na Travessa Pirajá, n.º 1954, bairro Marco, Belém/PA, CEP 66095-631, é responsável por este website institucional.\n\n'
                'Dúvidas sobre este aviso podem ser enviadas para: comercial@grupormts.com.',
          ),
          _Section(
            title: '2. Coleta e tratamento de dados pessoais',
            body:
                'Este website é estritamente informativo.\n\n'
                'O Grupo RMTS não coleta, não armazena e não realiza qualquer tratamento de dados pessoais dos visitantes deste site.\n\n'
                'Nenhum formulário de cadastro, preenchimento de dados ou envio de informações pessoais está disponível neste site para o público em geral.',
          ),
          _Section(
            title: '3. Cookies e rastreamento',
            body:
                'Este site não utiliza cookies de rastreamento, ferramentas de análise de comportamento nem pixels de terceiros.\n\n'
                'O único recurso técnico utilizado é o necessário para o funcionamento básico da aplicação web, sem qualquer identificação do visitante.',
          ),
          _Section(
            title: '4. Links externos',
            body:
                'Este site pode conter links para perfis em redes sociais ou serviços de terceiros (como WhatsApp e Instagram). Ao acessar esses serviços, você estará sujeito às respectivas políticas de privacidade, sobre as quais o Grupo RMTS não tem responsabilidade.',
          ),
          _Section(
            title: '5. Segurança',
            body:
                'A comunicação com este site é realizada por meio de protocolo seguro (HTTPS), garantindo a integridade e a confidencialidade da conexão.',
          ),
          _Section(
            title: '6. Alterações neste aviso',
            body:
                'Este Aviso de Privacidade pode ser revisado periodicamente. A data da última atualização é indicada no topo deste documento.',
          ),
          _Section(
            title: '7. Contato',
            body:
                'Para esclarecimentos sobre este aviso:\n\n'
                'Grupo RMTS\n'
                'E-mail: comercial@grupormts.com\n'
                'Telefone: +55 91 98532-0555\n'
                'Endereço: Tv. Pirajá, 1954 – Marco, Belém/PA, CEP 66095-631',
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;

  const _Section({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 10),
          Container(width: 48, height: 3, color: AppColors.accentRed),
          const SizedBox(height: 14),
          Text(
            body,
            style: const TextStyle(
              fontSize: 15,
              height: 1.75,
              color: AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
