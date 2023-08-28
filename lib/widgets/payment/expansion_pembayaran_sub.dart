import 'package:flutter/material.dart';

class ExpansionPembayaranSub extends StatelessWidget {
  const ExpansionPembayaranSub({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.zero,
      dense: true,
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          initiallyExpanded: true,
          textColor: Colors.black,
          iconColor: Colors.black,
          childrenPadding: EdgeInsets.zero,
          children: children,
        ),
      ),
    );
  }
}
