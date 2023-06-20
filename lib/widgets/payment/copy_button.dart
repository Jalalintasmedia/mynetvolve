import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynetvolve/helpers/copy_text.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    Key? key,
    required this.ctx,
    required this.copyType,
    required this.copiedData,
  }) : super(key: key);

  final BuildContext ctx;
  final String copyType;
  final String copiedData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => copyText(copiedData: copiedData, copyType: copyType),
      padding: const EdgeInsets.all(0),
      constraints: const BoxConstraints(),
      icon: const Icon(
        Icons.copy_outlined,
        size: 18,
      ),
    );
  }
}
