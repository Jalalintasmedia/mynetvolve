import 'package:flutter/material.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({
    Key? key,
    required this.shimmerTile,
    this.useDivider = true,
    this.itemCount = 20,
  }) : super(key: key);

  final Widget shimmerTile;
  final bool useDivider;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (ctx, i) {
        if (useDivider) {
          return const Divider(
            color: Colors.grey,
          );
        }
        return const SizedBox(height: 10);
      },
      itemBuilder: (ctx, i) => Padding(
        padding: EdgeInsets.only(
          top: i == 0 ? 5 : 0,
        ),
        child: shimmerTile,
      ),
    );
  }
}
