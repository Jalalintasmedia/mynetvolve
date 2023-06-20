//palette.dart
import 'package:flutter/material.dart'; 

class ThemeColors{
  static const accentColor = Color.fromRGBO(12, 193, 246, 0.9);
}

class Palette { 
  static const MaterialColor kToDark = MaterialColor( 
    0xff0057ff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50: const Color(0xff004ee6),//10% 
      100: const Color(0xff0046cc),//20% 
      200: const Color(0xff003db3),//30% 
      300: const Color(0xff003499),//40% 
      400: const Color(0xff002c80),//50% 
      500: const Color(0xff002366),//60% 
      600: const Color(0xff001a4c),//70% 
      700: const Color(0xff001133),//80% 
      800: const Color(0xff000919),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  ); 
  static const MaterialColor kToLight = MaterialColor( 
    0xff0057ff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50: const Color(0xff1a68ff),//10% 
      100: const Color(0xff3379ff),//20% 
      200: const Color(0xff4d89ff),//30% 
      300: const Color(0xff669aff),//40% 
      400: const Color(0xff80abff),//50% 
      500: const Color(0xff99bcff),//60% 
      600: const Color(0xffb3cdff),//70% 
      700: const Color(0xffccddff),//80% 
      800: const Color(0xffe6eeff),//90% 
      900: const Color(0xffffffff),//100% 
    }, 
  ); 
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below. 