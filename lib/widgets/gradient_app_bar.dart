import 'package:flutter/material.dart';

import '../core/palette.dart';

class GradientAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GradientAppBar({
    Key? key,
    required this.title,
    this.isCloseButton = false,
    this.leading,
    this.actions,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  final String title;
  final bool isCloseButton;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  State<GradientAppBar> createState() => _GradientAppBarState();
}

class _GradientAppBarState extends State<GradientAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ThemeColors.accentColor,
              Palette.kToDark,
            ],
          ),
        ),
      ),
      leading: widget.leading != null
          ? widget.leading
          : widget.isCloseButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_rounded),
                )
              : null,
      actions: widget.actions,
    );
  }
}
