// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:site_grupo_rmts/utils/api_client.dart';

import '../../environments/environments.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:site_grupo_rmts/data/models/usuario_logado_model.dart';

class AuthenticationService {
  static final AuthenticationService instance =
      AuthenticationService._internal();

  AuthenticationService._internal();

  final Dio _http = ApiClient.dio;

  // Tokens em memória
  String? accessToken;
  String? refreshToken;
  DateTime? expiresAt;
  Map<String, dynamic>? user;

  UsuarioLogadoModel? get usuarioLogado {
    if (user != null) {
      return UsuarioLogadoModel.fromJson(user!);
    }
    return null;
  }

  // ==========================
  // 🔹 Inicialização (chamada no main)
  // ==========================
  Future<void> init() async {
    await _loadSession();
  }

  // ===================================
  // 🔹 LOGIN → salva sessão + agenda refresh
  // ===================================
  Future<Response> login(String email, String senha) async {
    final response = await _http.post(
      Environments.login,
      data: {"email": email.trim().toLowerCase(), "senha": senha.trim()},
      options: Options(
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    if (response.data["accessToken"] != null) {
      await _saveSession(response.data);

      // NOVO: Busca dados complementares do usuário após salvar o Token
      try {
        final userId =
            response.data['user']?['uuid'] ??
            response.data['user']?['id']?.toString();
        if (userId != null) {
          final userResponse = await getUsuario(userId.toString());
          if (userResponse.data != null) {
            user = userResponse.data;
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('userData', jsonEncode(user));
          }
        }
      } catch (e) {
        log('[auth] Erro ao buscar dados complementares do usuario: $e');
      }

      scheduleAutoRefresh();
    }

    return response;
  }

  // ========================
  // 🔹 SALVA SESSÃO LOCALMENTE
  // ========================
  Future<void> _saveSession(Map<String, dynamic> data) async {
    accessToken = data['accessToken'];
    refreshToken = data['refreshToken'];
    user = data['user'];

    // Se o backend manda expiresIn em segundos
    if (data['expiresIn'] != null) {
      expiresAt = DateTime.now().add(Duration(seconds: data['expiresIn']));
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken ?? '');
    await prefs.setString('refreshToken', refreshToken ?? '');
    if (user != null) {
      await prefs.setString('userData', jsonEncode(user));
    }
    if (expiresAt != null) {
      await prefs.setString('expiresAt', expiresAt!.toIso8601String());
    }
  }

  // ========================
  // 🔹 CARREGA SESSÃO
  // ========================
  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
    refreshToken = prefs.getString('refreshToken');

    final userData = prefs.getString('userData');
    if (userData != null) {
      user = jsonDecode(userData);
    }

    final expiresStr = prefs.getString('expiresAt');
    if (expiresStr != null) {
      expiresAt = DateTime.tryParse(expiresStr);
    }

    if (accessToken != null && refreshToken != null) {
      scheduleAutoRefresh();
    }
  }

  // =========================
  // 🔹 LOGOUT (API + limpar local)
  // =========================
  Future<void> logout() async {
    try {
      if (refreshToken != null) {
        await _http.post(
          Environments.logout,
          data: {"refreshToken": refreshToken},
          options: Options(headers: {"Authorization": "Bearer $accessToken"}),
        );
      }
    } catch (e) {
      log('[auth] Erro ao chamar logout na API: $e');
    }

    // limpa memória
    accessToken = null;
    refreshToken = null;
    expiresAt = null;
    user = null;

    // limpa storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('userData');
    await prefs.remove('expiresAt');
  }

  // ============================================
  // 🔹 REFRESH AUTOMÁTICO DO ACCESS TOKEN
  // ============================================
  Future<bool> tryRefresh() async {
    if (refreshToken == null) {
      return false;
    }

    try {
      final response = await _http.post(
        Environments.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      accessToken = response.data['accessToken'];
      refreshToken = response.data['refreshToken'] ?? refreshToken;

      if (response.data['expiresIn'] != null) {
        expiresAt = DateTime.now().add(
          Duration(seconds: response.data['expiresIn']),
        );
      }

      await _saveSession({
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'expiresIn': response.data['expiresIn'],
        'user': user,
      });

      scheduleAutoRefresh();
      return true;
    } on DioException catch (e) {
      log('[auth] Error refreshing token (Dio): $e');
      return false;
    } catch (e) {
      return false;
    }
  }

  // =====================================================
  // 🔹 AGENDA RENOVAÇÃO AUTOMÁTICA
  // =====================================================
  void scheduleAutoRefresh() {
    if (expiresAt == null) return;

    final diff =
        expiresAt!.difference(DateTime.now()) - const Duration(seconds: 30);

    // log('[auth] scheduleAutoRefresh em: ${diff.inSeconds}s');

    if (diff.isNegative) {
      tryRefresh();
      return;
    }

    Future.delayed(diff, () async {
      await tryRefresh();
    });
  }

  // ================================
  // 🔹 HEADERS AUTENTICADOS
  // ================================
  Options authorizedHeaders() {
    return Options(
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );
  }

  // ==================================================
  // 🔹 PEGAR DADOS DO COLABORADOR
  // ==================================================
  Future<Response> getUsuario(String uuid) async {
    return await _http.get(
      "${Environments.usuario}/me",
      options: authorizedHeaders(),
    );
  }
}
