import 'package:flutter/material.dart';

class GameBannerContainer extends StatelessWidget {
  const GameBannerContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void enlargeImage(BuildContext context, String image) {
      showDialog(
        context: context,
        builder: (ctx) => Dialog(
          backgroundColor: Colors.transparent,
          child: Image.asset(image),
        ),
      );
    }

    // return Container(
    //   height: 150,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(15),
    //     color: Colors.grey.shade400,
    //   ),
    // );
    return InkWell(
      onTap: () => enlargeImage(context, 'assets/images/otello-banner.png'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset('assets/images/otello-banner.png'),
      ),
    );
  }
}
