import 'package:http/http.dart' as http;

Future<String?> getIPAddress() async {
  final url = Uri.parse('https://api.ipify.org');
  try {
    final response = await http.get(url);
    return response.statusCode == 200 ? response.body : '';
  } catch (e) {
    return '';
  }
}
