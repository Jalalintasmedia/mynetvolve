import 'package:url_launcher/url_launcher.dart';

void callCS() async {
  const String _custServiceNo = '02150919981';
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: _custServiceNo,
  );
  await launchUrl(launchUri);
}
