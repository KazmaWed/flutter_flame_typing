import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

extension FlameImageExtension on Image {
  SpriteAnimation getAnimation({
    required Vector2 size,
    required int frames,
    bool loop = true,
    double stepTime = 0.08,
  }) {
    final List<Sprite> spriteList = [];
    for (var i = 0; i < frames; i++) {
      final sprite = Sprite(this, srcSize: size, srcPosition: Vector2(size.x * i, 0));
      spriteList.add(sprite);
    }
    return SpriteAnimation.spriteList(spriteList, stepTime: stepTime, loop: loop);
  }
}
