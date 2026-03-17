// ignore_for_file: use_build_context_synchronously

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:site_grupo_rmts/environments/environments.dart';
import 'package:site_grupo_rmts/utils/api_client.dart';

class LoginService {
  final Dio _httpClient = ApiClient.dio;

  Future<Response> authService(
    String login,
    String senha,
    BuildContext context,
  ) async {
    return await _httpClient
        .post(
          Environments.login,
          data: {'email': login.toLowerCase().trim(), 'senha': senha.trim()},
        )
        .timeout(const Duration(seconds: 30));
  }

  Future<Response> usuarioService({
    required String uuid,
    required String token,
    required BuildContext context,
  }) async {
    return await _httpClient.get(
      '${Environments.usuario}/$uuid',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'authorization': "Bearer $token",
        },
      ),
    );
  }

  Future<Response> updateLogin(
    String login,
    String senha,
    BuildContext context,
    String uuid,
    String token,
  ) async {
    return await _httpClient
        .put(
          '${Environments.atualizaLogin}/$uuid',
          data: {
            'email': login.toLowerCase().trim(),
            'senha': senha.toLowerCase().trim(),
          },
          options: Options(
            headers: {
              "Content-Type": "application/json",
              'authorization': "Bearer $token",
            },
          ),
        )
        .timeout(const Duration(seconds: 60));
  }

  Future<Response> logoutService({required String token}) async {
    return await _httpClient.post(
      Environments.logout,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'authorization': "Bearer $token",
        },
      ),
    );
  }
}
