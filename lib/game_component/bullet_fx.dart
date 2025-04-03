import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

import '../game/typing_game.dart';
import '../extension/flame_image_extension.dart';

class BulletFx extends SpriteAnimationComponent with HasGameReference<TypingGame> {
  BulletFx({
    required super.position,
  }) : super(size: Vector2(90, 72), anchor: Anchor.centerRight);

  final _frames = 4;
  final _animationStepTime = 0.05;

  late final Image spriteImage;

  @override
  Future onLoad() async {
    spriteImage = await Flame.images.load('bullet_pink_fx.png');
    animation = spriteImage.getAnimation(
      size: Vector2(24, 24),
      frames: _frames,
      stepTime: _animationStepTime,
      loop: false,
    );
    add(RemoveEffect(delay: _frames * _animationStepTime));
  }
}
