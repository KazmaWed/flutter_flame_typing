import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

import '../game/typing_game.dart';
import '../extension/flame_image_extension.dart';

class TargetFx extends SpriteAnimationComponent with HasGameReference<TypingGame> {
  TargetFx({required super.position}) : super(size: Vector2(90, 90), anchor: Anchor.centerLeft);

  final _frames = 3;
  final _animationStepTime = 0.05;

  late final Image spriteImage;
  double timePassed = 0;

  @override
  Future onLoad() async {
    position.y = -12;
    spriteImage = await Flame.images.load('bullet_plasma_fx.png');
    animation = spriteImage.getAnimation(
      size: Vector2(30, 30),
      frames: _frames,
      stepTime: _animationStepTime,
      loop: false,
    );
    add(RemoveEffect(delay: _frames * _animationStepTime));
  }
}
