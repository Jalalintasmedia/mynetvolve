import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.centerLeft,
          radius: 1.5,
          colors: [
            Color.fromRGBO(12, 193, 246, 0.9),
            Color.fromRGBO(14, 84, 250, 0.9),
          ],
        ),
      ),
    );
  }
}