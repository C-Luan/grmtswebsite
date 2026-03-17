import 'package:dio/dio.dart';
import '../../environments/environments.dart';
import '../../utils/api_client.dart';
import '../../data/models/contracheque_model.dart';

class ContrachequeService {
  final Dio _http = ApiClient.dio;

  Future<List<ContrachequeModel>> listar() async {
    try {
      final response = await _http.get(Environments.contracheques);
      if (response.data is List) {
        return (response.data as List)
            .map((e) => ContrachequeModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> assinar(String uuid, String assinaturaBase64) async {
    try {
      await _http.post(
        "${Environments.contracheque}/$uuid${Environments.contrachequeAssinar}",
        data: {"assinatura": assinaturaBase64},
      );
    } catch (e) {
      rethrow;
    }
  }

  String getPdfUrl(String uuid, String token) {
    // Para Flutter Web, o ideal é passar o token via query ou cookie se o nginx exigir
    // Como estamos usando Dio com Interceptor, requisições diretas de link (<a> ou iframe src) 
    // não levam o Header Authorization automaticamente.
    // O backend/nginx deve estar preparado para receber o token via query se for via link direto.
    final baseUrl = ApiClient.dio.options.baseUrl;
    return "$baseUrl${Environments.contracheque}/$uuid?token=$token";
  }
}
