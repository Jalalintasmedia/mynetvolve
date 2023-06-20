import 'package:flutter/material.dart';

import '../../core/palette.dart';
import '../../helpers/check_if_tablet.dart';

class AddonGridView extends StatelessWidget {
  const AddonGridView({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Map<String, dynamic>> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet(context) ? 6 : 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
      ),
      shrinkWrap: true,
      clipBehavior: Clip.none,
      itemCount: list.length,
      itemBuilder: (ctx, i) => InkWell(
        onTap: (list[i]['routeName'] == '')
            ? null
            : () => Navigator.of(context).pushNamed(list[i]['routeName']),
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Palette.kToLight.shade100,
                  ThemeColors.accentColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          footer: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(
              list[i]['name'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
