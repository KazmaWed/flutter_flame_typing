import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../model/game_phase.dart';
import 'typing_game.dart';

class Horizon extends PositionComponent with HasGameReference<TypingGame> {
  final Vector2 _srcSize = Vector2(119, 100);
  final Vector2 _tileSize = Vector2(476, 400);
  final _speed = 3;

  // タイル
  late final Sprite _sprite;
  late final tileCount = (game.size.x / _tileSize.x).ceil() + 1;
  late final List<SpriteComponent> tiles = [];

  @override
  void onLoad() async {
    size = game.size;

    _sprite = Sprite(
      await Flame.images.load('floor02.png'),
      srcSize: _srcSize,
    );
    for (var i = 0; i < tileCount; i++) {
      final tile = SpriteComponent(
        sprite: _sprite,
        size: _tileSize,
        position: Vector2(
          -size.x / 2 + i * _tileSize.x,
          game.player.size.y / 2,
        ),
      );
      tiles.add(tile);
      add(tile);
    }
  }

  @override
  void update(dt) {
    super.update(dt);
    if (game.phase != GamePhase.playing) return;
    for (var tile in tiles) {
      tile.x -= _speed;
      if (tile.position.x + tile.size.x < -game.size.x / 2) {
        tile.position.x += tileCount * tile.size.x;
      }
    }
  }
}
