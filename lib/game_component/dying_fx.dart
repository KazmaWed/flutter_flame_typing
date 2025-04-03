import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

import '../game/typing_game.dart';
import '../extension/flame_image_extension.dart';

class DyingFx extends SpriteAnimationComponent with HasGameReference<TypingGame> {
  DyingFx() : super(size: Vector2(90, 90), anchor: Anchor.centerRight);

  final _frames = 8;
  final _animationStepTime = 0.05;

  late final Image spriteImage;

  @override
  Future onLoad() async {
    final random = Random();
    position = Vector2(
      game.player.position.x + random.nextInt(40) - 20,
      game.player.position.y + random.nextInt(40) - 20,
    );

    spriteImage = await Flame.images.load('dying_fx.png');
    animation = spriteImage.getAnimation(
      size: Vector2(30, 30),
      frames: _frames,
      stepTime: _animationStepTime,
      loop: false,
    );
    add(RemoveEffect(delay: _frames * _animationStepTime));
  }
}
