import 'package:url_launcher/url_launcher.dart';

void openExternalApplication(String url) async {
  final launchUri = Uri.parse(url);
  launchUrl(launchUri, mode: LaunchMode.externalApplication);
}

void callNumber(String number) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: number,
  );
  await launchUrl(launchUri);
}

void emailWithMailApp(String email) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  launchUrl(launchUri);
}