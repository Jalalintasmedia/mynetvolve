import 'package:flutter/material.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScanQRResultScreen extends StatelessWidget {
  const ScanQRResultScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  final String value;
  final VoidCallback screenClosed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Employee Profile',
        leading: IconButton(
          onPressed: () {
            screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: WebView(
        initialUrl: value,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
