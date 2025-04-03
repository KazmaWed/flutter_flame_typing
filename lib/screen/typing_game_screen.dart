import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../component/keyboard_layout_preview.dart';
import '../game/typing_game.dart';
import '../main.dart';
import '../model/kayboard_layout.dart';
import '../model/game_color.dart';
import '../model/level.dart';

class TypingGameScreen extends StatelessWidget {
  const TypingGameScreen({
    super.key,
    required this.level,
    required this.phisicalLayout,
    required this.virtualLayout,
    required this.se,
    required this.bgm,
  });

  final Level level;
  final KeyboardLayout phisicalLayout;
  final KeyboardLayout? virtualLayout;
  final bool se;
  final bool bgm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      bottomNavigationBar: const BottomAppBar(),
      backgroundColor: GameColor.pageBackground,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: gameSize.y,
              width: gameSize.x,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              alignment: Alignment.center,
              child: GameWidget(
                game: TypingGame(
                  gameSize: gameSize,
                  level: level,
                  bgm: bgm,
                  onTapQuit: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            KeyboardLayoutPreview(virtualLayout ?? phisicalLayout),
          ],
        ),
      ),
    );
  }
}
