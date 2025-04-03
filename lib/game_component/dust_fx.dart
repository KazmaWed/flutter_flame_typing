import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

import '../game/typing_game.dart';
import '../extension/flame_image_extension.dart';

class DustFx extends SpriteAnimationComponent with HasGameReference<TypingGame> {
  DustFx() : super(size: Vector2(96, 96), anchor: Anchor.centerRight);

  final _frames = 8;
  final _animationStepTime = 0.05;

  late final Image spriteImage;

  @override
  Future onLoad() async {
    position = Vector2(
      game.player.position.x - game.player.size.x / 2,
      game.player.position.y - (size.y - game.player.size.y) / 2,
    );

    spriteImage = await Flame.images.load('dust.png');
    animation = spriteImage.getAnimation(
      size: Vector2(32, 32),
      frames: _frames,
      stepTime: _animationStepTime,
      loop: false,
    );
    add(RemoveEffect(delay: _frames * _animationStepTime));
  }
}
