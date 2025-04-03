import 'package:flutter/material.dart';
import 'package:flutter_flame_typing/model/game_color.dart';

const textTheme = TextTheme(
  bodyMedium: TextStyle(fontSize: 18),
  bodyLarge: TextStyle(fontSize: 20),
  headlineMedium: TextStyle(fontSize: 28),
);

extension TextThemeExtension on TextTheme {
  static const outlineWidth = 2.0;

  TextStyle get outlineLarge => textTheme.bodyLarge!.copyWith(
        color: GameColor.black,
        fontWeight: FontWeight.bold,
        shadows: [
          for (var d in [-outlineWidth, outlineWidth])
            Shadow(
              offset: Offset(d.toDouble(), 0),
              color: GameColor.white,
            ),
          for (var d in [-outlineWidth, outlineWidth])
            Shadow(
              offset: Offset(0, d.toDouble()),
              color: GameColor.white,
            ),
          for (var d in [-outlineWidth, outlineWidth])
            Shadow(
              offset: Offset(d.toDouble(), d.toDouble()),
              color: GameColor.white,
            ),
          for (var d in [-outlineWidth, outlineWidth])
            Shadow(
              offset: Offset(d.toDouble(), -d.toDouble()),
              color: GameColor.white,
            ),
        ],
      );
}
