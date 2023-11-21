import 'package:flutter/material.dart';

import '../../core/palette.dart';

class MetodePembayaranTile extends StatelessWidget {
  const MetodePembayaranTile({
    Key? key,
    required this.title,
    required this.image,
    required this.contentWidget,
    this.noImage = false,
  }) : super(key: key);

  final String title;
  final String image;
  final Widget contentWidget;
  final bool noImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
      ),
      elevation: 0,
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.end,
          leading: noImage ? null : LayoutBuilder(
            builder: (ctx, constraints) => Container(
              width: constraints.maxWidth * 0.25,
              padding: const EdgeInsets.all(3),
              child: Image.asset('assets/images/$image'),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
          trailing: const Icon(Icons.radio_button_checked),
          textColor: Colors.black,
          iconColor: Palette.kToDark,
          collapsedIconColor: Colors.grey,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
          tilePadding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            contentWidget,
          ],
        ),
      ),
    );
  }
}
