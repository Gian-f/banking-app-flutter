import 'package:flutter/foundation.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:http/http.dart' as http;

abstract class BaseRepository {
  Future<T> safeApiCall<T>(Future<T> Function() call) async {
    try {
      var response = await call();
      if (response is http.Response) {
        if (response.statusCode == 200) {
          return response.body as T;
        } else {
          throw Exception('Chamada de API falhou: ${response.body}');
        }
      } else {
        throw Exception('Resposta inesperada: $response');
      }
    } catch (e) {
      if (kDebugMode) {
        FlutterLogs.logInfo(
            "TAG", 'Serviço fora do ar: ${e.toString()}', e.toString());
      }
      rethrow;
    }
  }
}
