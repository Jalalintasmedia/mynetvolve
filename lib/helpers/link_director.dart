import 'package:url_launcher/url_launcher.dart';

void openExternalApplication(String url) async {
  final launchUri = Uri.parse(url);
  launchUrl(launchUri, mode: LaunchMode.externalApplication);
}