import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../game/typing_game.dart';
import '../model/game_color.dart';
import 'target.dart';

class LifeBar extends RectangleComponent with HasGameRef<TypingGame> {
  LifeBar({required this.max})
      : super(
          size: Vector2(72, 10),
          paint: Paint()..color = GameColor.white,
        );
  final double max;
  double _damage = 0;
  double get _life => max - _damage;
  double get _fxSpeed => _life != 0 ? size.x * 4 / (game.word!.length + 3) : size.x * 1.5;

  final double borderWidth = 2.0;
  late final double lifeBarInnerLength = size.x - borderWidth * 2;
  late final double lifeBarBlockLength = lifeBarInnerLength / max;

  late final effectRect = RectangleComponent(
    size: Vector2(0.0, size.y - borderWidth * 2),
    position: Vector2(size.x - borderWidth, borderWidth),
    paint: Paint()..color = GameColor.highlight,
    anchor: Anchor.topLeft,
  );
  late final damageRect = RectangleComponent(
    size: Vector2(0.0, size.y - borderWidth * 2),
    position: Vector2(size.x - borderWidth, borderWidth),
    paint: Paint()..color = GameColor.black,
    anchor: Anchor.topLeft,
  );

  @override
  FutureOr<void> onLoad() {
    addAll([effectRect, damageRect]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (_life > 0) follow(game.target);
    effectRect.position.x = (lifeBarInnerLength * _life / max) + borderWidth;
    effectRect.size.x = (lifeBarInnerLength * _damage / max);
    if (damageRect.size.x < effectRect.size.x) {
      damageRect.size.x += _fxSpeed * dt;
      damageRect.position.x = lifeBarInnerLength - damageRect.size.x + borderWidth;
    }
    if (damageRect.position.x <= borderWidth) {
      removeAll(children);
      removeFromParent();
    }
    super.update(dt);
  }

  void damage() {
    _damage += 1;
    if (_life == 0) {
      add(OpacityEffect.fadeOut(EffectController(duration: 0.4)));
      removeFromParent();
      game.world.add(this);
    }
  }

  void follow(Target target) {
    position = Vector2(
      target.x + (target.size.x - size.x) / 2,
      target.position.y + target.size.y / 2 + 10,
    );
  }
}
