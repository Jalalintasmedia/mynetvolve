import 'package:flutter/material.dart';

class InDevelopmentContent extends StatelessWidget {
  const InDevelopmentContent({ Key? key }) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.center,
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
                    child: const Text(
                      'This Page is Under Construction',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}