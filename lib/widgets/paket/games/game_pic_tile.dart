import 'package:flutter/material.dart';

class GamePicTile extends StatelessWidget {
  const GamePicTile({
    Key? key,
    this.width = 80,
    this.height,
  }) : super(key: key);

  final double width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
