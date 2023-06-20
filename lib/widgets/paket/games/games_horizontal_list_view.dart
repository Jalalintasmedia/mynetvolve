import 'package:flutter/material.dart';

import 'game_pic_tile.dart';

class GamesHorizontalListView extends StatelessWidget {
  const GamesHorizontalListView({Key? key,
  required this.itemCount,}) : super(key: key);

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (ctx, i) => const SizedBox(width: 5),
        itemCount: itemCount,
        itemBuilder: (ctx, i) => const GamePicTile(),
      ),
    );
  }
}

