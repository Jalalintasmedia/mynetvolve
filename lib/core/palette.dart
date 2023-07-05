//palette.dart
import 'package:flutter/material.dart'; 

class ThemeColors{
  static const accentColor = Color.fromRGBO(12, 193, 246, 0.9);
}

class Palette { 
  static const MaterialColor kToDark = MaterialColor( 
    0xff0196f8, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50: Color(0xff0187df),//10% 
      100: Color(0xff0178c6),//20% 
      200: Color(0xff0169ae),//30% 
      300: Color(0xff015a95),//40% 
      400: Color(0xff014b7c),//50% 
      500: Color(0xff003c63),//60% 
      600: Color(0xff002d4a),//70% 
      700: Color(0xff001e32),//80% 
      800: Color(0xff000f19),//90% 
      900: Color(0xff000000),//100% 
    }, 
  ); 
  static const MaterialColor kToLight = MaterialColor( 
    0xff0196f8, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50: Color(0xff1aa1f9),//10% 
      100: Color(0xff34abf9),//20% 
      200: Color(0xff4db6fa),//30% 
      300: Color(0xff67c0fb),//40% 
      400: Color(0xff80cbfc),//50% 
      500: Color(0xff99d5fc),//60% 
      600: Color(0xffb3e0fd),//70% 
      700: Color(0xffcceafe),//80% 
      800: Color(0xffe6f5fe),//90% 
      900: Color(0xffffffff),//100% 
    }, 
  ); 
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below. 