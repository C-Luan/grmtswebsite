import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  // Base URLs and Core Information
  static final String baseURL = dotenv.env['BASE_URL'] ?? '';
  static final String socketApiUrl = dotenv.env['SOCKET_API_URL'] ?? '';
  static final String politicaDePrivacidade =
      dotenv.env['POLITICA_DE_PRIVACIDADE'] ?? '';
  static final String usuario = '/usuario';

  // ============================
  // Authentication and User Endpoints
  // ============================

  // NOVO: apontando para as novas rotas do servidor
  static final String login = '/login';
  static final String logout = '/auth/logout';
  static final String refreshToken = '/auth/refresh';

  static final String atualizaLogin = '/atualizalogin';
  static final String createUser = '/createuser';
  static final String createlogin = '/createlogin';

  static final String createColaborador = '/colaborador';
  static final String atualizarcolaborador = '/putcolab/:id';
  static final String atualizarCentroCusto = '/putcentrocusto/:id';
  static final String atualizarFuncao = '/putfuncao/:id';
  static final String getColaboradores = '/colaboradores';
  static final String getColaboradoresContrato = '/colaboradores/por-contrato';
  static final String advertencias = '/advertencias';
  static final String convocacoes = '/convocacoes';
  static final String suspensoes = '/suspensoes';
  static final String certificacoes = '/certificacoes';
  static final String admissao = '/admissao';
  static final String historicocertificacao = '/historicocertificacao';

  static final String historicocertificacaogetcursosprazo =
      '/historicocertificacao/getcursosprazo';
  static final String contratos = '/contrato';

  static final String empresa = '/empresa';
  static final String contrachequeUpload = "/contracheque/upload";

  // New Endpoints
  static final String desligamentos = '/desligamentos';
  static final String materiais = '/materiais';
  static final String exames = '/exames';
  static final String rondahistorico = '/rondahistorico';
  static final String rondahistoricoRelatorio = '/rondahistorico/relatorio';

  static final String contracheques = '/contracheques';
  static final String contracheque = '/contracheque';
  static final String contrachequeAssinar = '/assinar';
}
