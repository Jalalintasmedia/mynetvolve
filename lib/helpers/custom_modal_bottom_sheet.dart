import 'package:flutter/material.dart';

void showCustomModalBottomSheet(BuildContext context, List<Widget> children) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    builder: (context) {
      return Wrap(
        children: [
          Column(
            children: children,
          )
        ],
      );
    },
  );
}
