import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../model/game_color.dart';
import '../model/game_phase.dart';
import '../model/game_score.dart';
import '../model/level.dart';
import 'typing_game.dart';
import 'typing_game_restart_button.dart';

class TextOverlay extends PositionComponent with HasGameReference<TypingGame> {
  TextOverlay();

  double get floorY => game.size.y / 2 + game.player.floorY;
  double get spaceMiddleY => (game.size.y - floorY + 100) / 2;
  double get floorMiddleY => (game.size.y + floorY) / 2;

  void _setMessage(String message) {
    messageText.text = message;
    messageOutlineText.text = message;
  }

  void _setWord(String word) {
    wordText.text = word;
    wordOutlineText.text = word;
  }

  void _setTyped(String typed) {
    typedText.text = typed;
    typedText.position.x = wordText.position.x - wordText.size.x / 2;
  }

  void _hideAllText() {
    messageText.text = '';
    messageOutlineText.text = '';
    wordText.text = '';
    wordOutlineText.text = '';
    scoreText.text = '';
    typedText.text = '';
    scoreText.text = '';
    timeText.text = '';
    wordRect.removeFromParent();
  }

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
  late final TextComponent timeText = TextComponent(
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
    add(timeText);
    add(scoreText);
    add(quitButton);
  }

  @override
  void update(dt) {
    super.update(dt);
    timeText.text = game.score.time.toStringAsFixed(2);
    scoreText.text = 'SCORE : ${game.score.totalCorrectType}';
    if (game.phase == GamePhase.starting) {
      _setMessage(game.level.title);
      _setWord('');
      _setTyped('');
    } else if (game.phase == GamePhase.gameover) {
      _hideAllText();
    } else if (game.phase == GamePhase.clear) {
      _hideAllText();
    } else if (game.word == null) {
      _setWord('');
      _setTyped('');
    } else {
      final evelts = game.level.events;
      if (evelts.length <= game.currentEventIndex) {
        _hideAllText();
      }
      final event = game.level.events[game.currentEventIndex];
      if (event is Message) {
        _setMessage(event.value);
        _setWord('');
        _setTyped('');
      } else if (event is Obstacle) {
        _setMessage('');
        _setWord(game.word ?? '');
        final typedCount = game.currentObstacleScore?.correct ?? 0;
        _setTyped(game.word?.substring(0, typedCount) ?? '');
      }
    }
  }
}
