import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:site_grupo_rmts/services/login/authentication_service.dart';

class ApiClient {
  static final dio = Dio(
    BaseOptions(
      // baseUrl: kDebugMode
      // ? 'http://localhost:3001'
      // : 'https://siged.reportfacil.com.br',
      baseUrl: 'https://siged.reportfacil.com.br',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  static void setup() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = AuthenticationService.instance.accessToken;

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          final req = error.requestOptions;

          // 🚫 1) Nunca tenta refresh se a rota for /auth/refresh
          if (req.path.contains("/refresh") ||
              req.path.contains("/auth/refresh")) {
            return handler.next(error);
          }

          // 🚫 2) Se já tentou refresh antes nessa requisição → não tenta de novo
          if (req.headers["x-refresh-attempt"] == true) {
            return handler.next(error);
          }

          // 🚫 3) Só trata erro 401 válido
          if (error.response?.statusCode == 401) {
            final ok = await AuthenticationService.instance.tryRefresh();

            if (ok) {
              // marca que essa é uma tentativa de retry
              req.headers["x-refresh-attempt"] = true;

              final newOptions = Options(
                method: req.method,
                headers: {
                  ...req.headers,
                  "Authorization":
                      "Bearer ${AuthenticationService.instance.accessToken}",
                },
                contentType: req.contentType,
                responseType: req.responseType,
              );

              try {
                final response = await dio.request(
                  req.path,
                  data: req.data,
                  queryParameters: req.queryParameters,
                  options: newOptions,
                );

                return handler.resolve(response);
              } catch (e) {
                return handler.next(error);
              }
            }
          }

          return handler.next(error);
        },
      ),
    );
  }

  static String encode(Object data) => json.encode(data);
  static dynamic decode(String data) => json.decode(data);
}
