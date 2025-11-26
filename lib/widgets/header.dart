import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class Header extends StatelessWidget {
  final VoidCallback onQuemSomosTap;
  final VoidCallback onEmpresasTap;
  final VoidCallback onClientesTap;
  final VoidCallback onTrabalheTap;
  final VoidCallback onLocalizacaoTap;
  final VoidCallback onContatoTap;

  const Header({
    super.key,
    required this.onQuemSomosTap,
    required this.onEmpresasTap,
    required this.onClientesTap,
    required this.onTrabalheTap,
    required this.onLocalizacaoTap,
    required this.onContatoTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final menuItems = [
      _HeaderItem(label: 'Quem Somos', onTap: onQuemSomosTap),
      _HeaderItem(label: 'Empresas', onTap: onEmpresasTap),
      _HeaderItem(label: 'Clientes', onTap: onClientesTap),
      _HeaderItem(label: 'Trabalhe Conosco', onTap: onTrabalheTap),
      _HeaderItem(label: 'Localização', onTap: onLocalizacaoTap),
      _HeaderItem(label: 'Contato', onTap: onContatoTap),
    ];

    return Container(
      color: AppColors.primaryBlue,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Image.asset(
                'assets/logos/logo_grmts.png',
                height: 50,
              ),
              const SizedBox(width: 12),
              
            ],
          ),
          const Spacer(),
          if (!isMobile)
            Row(
              children: menuItems
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: InkWell(
                          onTap: e.onTap,
                          child: Text(
                            e.label.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          if (isMobile)
            PopupMenuButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              itemBuilder: (context) {
                return menuItems
                    .map(
                      (e) => PopupMenuItem(
                        onTap: e.onTap,
                        child: Text(e.label),
                      ),
                    )
                    .toList();
              },
            ),
        ],
      ),
    );
  }
}

class _HeaderItem {
  final String label;
  final VoidCallback onTap;
  _HeaderItem({required this.label, required this.onTap});
}
