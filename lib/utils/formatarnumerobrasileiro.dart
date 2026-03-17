String formatarNumeroBrasileiro(String numero) {
  // Remove espaços, parênteses, traços e outros caracteres não numéricos
  String apenasNumeros = numero.replaceAll(RegExp(r'[^0-9]'), '');

  // Se for um número com DDD e tiver 11 dígitos (ex: 91 9XXXX XXXX), remove o nono dígito
  if (apenasNumeros.length == 11 && apenasNumeros[2] == '9') {
    apenasNumeros = apenasNumeros.substring(0, 2) + apenasNumeros.substring(3);
  }

  // Adiciona o DDI do Brasil (55) se ainda não tiver
  if (!apenasNumeros.startsWith('55')) {
    apenasNumeros = '55$apenasNumeros';
  }

  return apenasNumeros;
}
