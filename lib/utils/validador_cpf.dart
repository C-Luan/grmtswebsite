class CPFValidator {
  /// Valida um número de CPF (Cadastro de Pessoa Física) brasileiro.
  /// Retorna null se o CPF for válido, ou uma mensagem de erro caso contrário.
  static String? validate(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return null; // Ou 'Campo obrigatório'
    }

    // Remove caracteres não numéricos (pontos e traços)
    cpf = cpf.replaceAll(RegExp(r'\D'), '');

    // Verifica se o CPF tem 11 dígitos após a remoção dos caracteres
    if (cpf.length != 11) {
      return 'O CPF deve conter 11 dígitos.';
    }

    // Verifica se todos os dígitos são iguais (ex: "111.111.111-11")
    // Esses CPFs são considerados inválidos pela maioria das regras de validação
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return 'CPF inválido: todos os dígitos são iguais.';
    }

    // Calcula o primeiro dígito verificador
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstVerifier = 11 - (sum % 11);
    if (firstVerifier > 9) {
      firstVerifier = 0;
    }

    // Verifica o primeiro dígito
    if (int.parse(cpf[9]) != firstVerifier) {
      return 'CPF inválido.';
    }

    // Calcula o segundo dígito verificador
    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondVerifier = 11 - (sum % 11);
    if (secondVerifier > 9) {
      secondVerifier = 0;
    }

    // Verifica o segundo dígito
    if (int.parse(cpf[10]) != secondVerifier) {
      return 'CPF inválido.';
    }

    return null; // CPF válido
  }
}
