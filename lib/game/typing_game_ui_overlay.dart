import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../model/game_color.dart';
import '../model/game_phase.dart';
import '../model/level.dart';
import 'typing_game.dart';
import 'typing_game_restart_button.dart';

class TextOverlay extends PositionComponent with HasGameReference<TypingGame> {
  TextOverlay();

  double get floorY => game.size.y / 2 + game.player.floorY;
  double get spaceMiddleY => (game.size.y - floorY + 100) / 2;
  double get floorMiddleY => (game.size.y + floorY) / 2;

  final _wordRender = TextPaint(
    style: const TextStyle(
      fontSize: 54.0,
      fontFamily: 'MadouFutoMaru',
      color: GameColor.black,
    ),
  );
  final _wordOutlineRender = TextPaint(
    style: TextStyle(
      fontSize: 54.0,
      fontFamily: 'MadouFutoMaru',
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..color = GameColor.white,
    ),
  );
  final _typedRender = TextPaint(
    style: TextStyle(
      fontSize: 54.0,
      fontFamily: 'MadouFutoMaru',
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..color = GameColor.highlight,
    ),
  );
  final _textRenderer = TextPaint(
    style: const TextStyle(
      fontSize: 32.0,
      fontFamily: 'MadouFutoMaru',
      color: GameColor.white,
    ),
  );

  // 画面要素
  late final TextComponent messageText = TextComponent(
    position: Vector2(size.x * 0.5, spaceMiddleY),
    anchor: Anchor.center,
    textRenderer: _wordRender,
  );
  late final TextComponent messageOutlineText = TextComponent(
    position: Vector2(size.x * 0.5, spaceMiddleY),
    anchor: Anchor.center,
    textRenderer: _wordOutlineRender,
  );
  late final TextComponent wordText = TextComponent(
    position: Vector2(size.x * 0.5, floorMiddleY),
    anchor: Anchor.center,
    textRenderer: _wordRender,
  );
  late final TextComponent wordOutlineText = TextComponent(
    position: Vector2(size.x * 0.5, floorMiddleY),
    anchor: Anchor.center,
    textRenderer: _wordOutlineRender,
  );
  late final TextComponent typedText = TextComponent(
    position: Vector2(size.x * 0.5, floorMiddleY),
    anchor: Anchor.centerLeft,
    textRenderer: _typedRender,
  );
  late final TextComponent scoreText = TextComponent(
    position: Vector2(20, 20),
    textRenderer: _textRenderer,
  );
  late final TextComponent distanceText = TextComponent(
    position: Vector2(size.x - 20, 20),
    textRenderer: _textRenderer,
    anchor: Anchor.topRight,
  );
  late final RectangleComponent wordRect = RectangleComponent(
    position: Vector2(size.x * 0.5, floorMiddleY),
    size: Vector2(game.size.x / 2, 80),
    anchor: Anchor.center,
    paint: Paint()..color = GameColor.wordBackground,
  );
  // late final restartButton = RestartButton();
  late final quitButton = QuitButton();

  @override
  void onLoad() async {
    size = Vector2(game.size.x, game.size.y);
    anchor = Anchor.center;
    add(messageOutlineText);
    add(messageText);
    add(wordRect);
    add(wordOutlineText);
    add(typedText);
    add(wordText);
    add(distanceText);
    add(scoreText);
    // add(restartButton);
    add(quitButton);
  }

  @override
  void update(dt) {
    super.update(dt);
    distanceText.text = game.distance.toStringAsFixed(2);
    scoreText.text = 'SCORE : ${game.score.totalCorrectType}';
    if (game.phase == GamePhase.starting) {
      messageText.text = game.level.title;
      messageOutlineText.text = game.level.title;
      wordText.text = '';
      wordOutlineText.text = '';
      typedText.text = '';
    } else if (game.phase == GamePhase.gameover) {
      messageText.text = 'SCORE : ${game.score}';
      messageOutlineText.text = 'SCORE : ${game.score}';
      wordText.text = '';
      wordOutlineText.text = '';
      scoreText.text = '';
      typedText.text = '';
    } else if (game.word == null) {
      wordText.text = '';
      wordOutlineText.text = '';
      typedText.text = '';
    } else {
      final evelts = game.level.events;
      if (evelts.length <= game.currentEventIndex) {
        messageText.text = 'LEVEL CLEAR!';
        messageOutlineText.text = 'LEVEL CREAR!';
        wordText.text = '';
        wordOutlineText.text = '';
        typedText.text = '';
        return;
      }
      final event = game.level.events[game.currentEventIndex];
      if (event is Message) {
        messageText.text = event.value;
        messageOutlineText.text = event.value;
        wordText.text = '';
        wordOutlineText.text = '';
        typedText.text = '';
      } else if (event is Obstacle) {
        messageText.text = '';
        messageOutlineText.text = '';
        wordText.text = game.word!;
        wordOutlineText.text = game.word!;
        final typed = game.currentObstacleScore?.correct ?? 0;

        typedText.text = game.word?.substring(0, typed) ?? '';
        typedText.position.x = wordText.position.x - wordText.size.x / 2;
      }
    }
  }
}
