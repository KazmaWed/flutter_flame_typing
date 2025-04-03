import 'package:flutter/material.dart';

import '../model/game_color.dart';
import '../model/kayboard_layout.dart';

class KeyBox extends StatelessWidget {
  const KeyBox(
    this.letter,
    this.keySize, {
    this.padding = 2,
    super.key,
  });
  final String letter;
  final double keySize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        width: keySize,
        height: keySize,
        decoration: BoxDecoration(
          border: Border.all(color: GameColor.white, width: 1),
          borderRadius: BorderRadius.circular(4),
          color: GameColor.pageBackground,
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: style,
        ),
      ),
    );
  }
}

class KeyboardLayoutPreview extends StatelessWidget {
  const KeyboardLayoutPreview(this.layout, {super.key});
  final KeyboardLayout? layout;
  final keySize = 40.0;
  final padding = 4.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: GameColor.white, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: layout != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var letter in layout!.keyMap.r4.defaultLayer.split(''))
                      KeyBox(letter.toUpperCase(), keySize),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: (keySize + padding) * 1.5),
                    for (var letter in layout!.keyMap.r3.defaultLayer.split(''))
                      KeyBox(letter.toUpperCase(), keySize),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: (keySize + padding) * 1.75),
                    for (var letter in layout!.keyMap.r2.defaultLayer.split(''))
                      KeyBox(letter.toUpperCase(), keySize),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: (keySize + padding) * 2.25),
                    for (var letter in layout!.keyMap.r1.defaultLayer.split(''))
                      KeyBox(letter.toUpperCase(), keySize),
                  ],
                ),
              ],
            )
          : null,
    );
  }
}
