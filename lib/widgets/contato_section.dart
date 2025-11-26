import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/responsive.dart';

class ContatoSection extends StatefulWidget {
  const ContatoSection({super.key});

  @override
  State<ContatoSection> createState() => _ContatoSectionState();
}

class _ContatoSectionState extends State<ContatoSection> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _assuntoController = TextEditingController();
  final _mensagemController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _assuntoController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  void _enviar() {
    if (_formKey.currentState?.validate() ?? false) {
      // aqui você pode integrar com backend, email, Supabase etc.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mensagem enviada com sucesso!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.accentRed,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 24 : 200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ENTRE EM CONTATO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _campo(
                  label: 'Nome Completo',
                  controller: _nomeController,
                ),
                const SizedBox(height: 12),
                _campo(
                  label: 'Seu e-mail',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                _campo(
                  label: 'Assunto',
                  controller: _assuntoController,
                ),
                const SizedBox(height: 12),
                _campo(
                  label: 'Sua mensagem',
                  controller: _mensagemController,
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isMobile ? double.infinity : 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: _enviar,
                    child: const Text('Enviar'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _campo({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Preencha este campo';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
      ),
    );
  }
}
