import 'package:flutter/material.dart';

class TidakAdaDataScreen extends StatelessWidget {
  const TidakAdaDataScreen({
    Key? key,
    this.text,
    this.isCenter = true,
  }) : super(key: key);

  final String? text;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BnetfitLogo(padding: 20),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Color.fromRGBO(0, 236, 255, 0.5),
                            Color.fromRGBO(0, 26, 255, 0.9),
                          ],
                        ).createShader(bounds);
                      },
                      child: Text(
                        text ?? 'Tidak Ada Data',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
