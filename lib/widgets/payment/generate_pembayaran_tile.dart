import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../core/palette.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/payment/metode_pembayaran_tile.dart';

class GeneratePembayaranTile extends StatelessWidget {
  const GeneratePembayaranTile({
    Key? key,
    required this.title,
    required this.image,
    required this.tutorialText,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  final String title;
  final String image;
  final String tutorialText;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return MetodePembayaranTile(
      title: title,
      image: image,
      contentWidget: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Html(
              data: tutorialText,
              shrinkWrap: true,
              style: {
                'body': Style(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  lineHeight: const LineHeight(1.5),
                ),
              },
            ),
            const SizedBox(height: 15),
            RoundedButton(
              onPressed: onPressed,
              text: buttonText,
              useSide: false,
              useShadow: false,
              bgColor: Palette.kToDark,
            ),
          ],
        ),
      ),
    );
  }
}
