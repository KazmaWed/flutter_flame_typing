import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';

import '../game/typing_game.dart';
import '../model/game_color.dart';

// class RestartButton extends TextComponent with HasGameReference<TypingGame>, TapCallbacks {
//   @override
//   Future onLoad() async {
//     text = 'Restart';
//     anchor = Anchor.bottomRight;
//     position = Vector2(game.size.x - 20, game.size.y - 20);
//     textRenderer = TextPaint(
//       style: const TextStyle(
//         fontSize: 32.0,
//         fontFamily: 'MadouFutoMaru',
//         color: GameColor.white,
//       ),
//     );
//   }

//   @override
//   void onTapUp(TapUpEvent event) {
//     game.restart();
//   }
// }

class QuitButton extends TextComponent with HasGameReference<TypingGame>, TapCallbacks {
  @override
  Future onLoad() async {
    text = 'Quit';
    anchor = Anchor.bottomLeft;
    position = Vector2(20, game.size.y - 20);
    textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 32.0,
        fontFamily: 'MadouFutoMaru',
        color: GameColor.white,
      ),
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.onTapQuit();
  }
}
