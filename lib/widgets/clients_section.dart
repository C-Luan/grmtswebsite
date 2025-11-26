import 'package:flutter/material.dart';
import 'package:site_grupo_rmts/core/constants/app_colors.dart';
import 'package:site_grupo_rmts/core/responsive.dart';

class ClientsSection extends StatefulWidget {
  const ClientsSection({super.key});

  @override
  State<ClientsSection> createState() => _ClientsSectionState();
}

class _ClientsSectionState extends State<ClientsSection>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _autoScrollController;

  bool _hoveringList = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // Controller do autoplay
    _autoScrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25), // Velocidade
    )..addListener(_autoScroll);

    _autoScrollController.repeat(); // autoplay INFINITO
  }

  void _autoScroll() {
    if (_hoveringList) return; // pausa no hover

    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;

    if (current >= max) {
      // Reset instantâneo quando chega no final
      _scrollController.jumpTo(0);
    } else {
      // Move lentamente para frente
      _scrollController.jumpTo(current + 0.8); // suavidade
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // 37 logos → duplicamos a lista para um loop perfeito
    final logos = List.generate(37, (i) => 'assets/logos/clientes/${i + 1}.png');
    final duplicatedLogos = [...logos, ...logos];

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 16 : 160,
      ),
      child: Column(
        children: [
          const Text(
            'O Grupo RMTS orgulha-se de atender instituições de destaque.',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 60),

          /// LISTA HORIZONTAL COM AUTOPLAY INFINITO
          MouseRegion(
            onEnter: (_) => setState(() => _hoveringList = true),
            onExit: (_) => setState(() => _hoveringList = false),
            child: SizedBox(
              height: isMobile ? 120 : 150,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(), // autoplay controla
                itemCount: duplicatedLogos.length,
                separatorBuilder: (_, __) => const SizedBox(width: 40),
                itemBuilder: (context, index) {
                  return _HoverLogo(
                    imagePath: duplicatedLogos[index],
                    width: isMobile ? 120 : 160,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

/// Efeito grayscale + hover colorido
class _HoverLogo extends StatefulWidget {
  final String imagePath;
  final double width;

  const _HoverLogo({required this.imagePath, required this.width});

  @override
  State<_HoverLogo> createState() => _HoverLogoState();
}

class _HoverLogoState extends State<_HoverLogo> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: ColorFiltered(
          colorFilter: _hovering
              ? const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.dst,
                )
              : const ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0, //
                  0.2126, 0.7152, 0.0722, 0, 0, //
                  0.2126, 0.7152, 0.0722, 0, 0, //
                  0, 0, 0, 1, 0,
                ]),
          child: Image.asset(
            widget.imagePath,
            width: widget.width,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
