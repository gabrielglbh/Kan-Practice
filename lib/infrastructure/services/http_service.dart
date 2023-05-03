import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class HttpService {
  Future<http.Response> postOpenAI(Map body) async {
    return http.post(Uri.https('api.openai.com', '/v1/completions'),
        headers: {
          'Authorization': 'Bearer [OPEN_AI_TOKEN]',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));
  }
}
