import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mynetvolve/helpers/link_director.dart';
import 'package:mynetvolve/widgets/clickable_image.dart';
import 'package:mynetvolve/widgets/gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoDetailScreen extends StatelessWidget {
  const PromoDetailScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: title),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClickableImage(image: image, height: 0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Html(
                  data: description,
                  onLinkTap: (url, _, __, ___) async {
                    final uri = Uri.parse(url!);
                    print('URL: $url, URI: $uri');
                    openExternalApplication(url);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
