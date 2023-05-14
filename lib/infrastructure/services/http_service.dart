import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class HttpService {
  Future<http.Response> getOpenAIPrompt(String uid, List<String> words) async {
    return http.get(
      Uri.https(
        'us-central1-kanpractice.cloudfunctions.net',
        '/getOpenAIPrompt',
        {'words': words},
      ),
      headers: {'Authorization': uid},
    );
  }
}
