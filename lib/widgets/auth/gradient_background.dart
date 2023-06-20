import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/office_bg2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(12, 193, 246, 0.9),
                Color.fromRGBO(14, 84, 250, 0.9),
              ],
              // stops: [0.5,0.6],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        child,
        // const Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(vertical: 15),
        //     child: Text(
        //       'Butuh Bantuan?',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 12,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
