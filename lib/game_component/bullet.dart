import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

import '../extension/flame_image_extension.dart';
import 'bullet_fx.dart';
import '../game/typing_game.dart';

class Bullet extends SpriteAnimationComponent with HasGameReference<TypingGame> {
  Bullet({
    required this.onHit,
    required this.id,
    required this.critical,
  }) : super(size: Vector2(72, 72), anchor: Anchor.centerRight);

  final Function(Bullet) onHit;
  final int id;
  final bool critical;

  late final Image spriteImage;
  final _animationStepTime = 1 / 30;
  final _worldEdgeX = 400.0;

  final initialSpeed = 2.0;
  final accel = 10.0;
  final friction = 0.15;

  late double speed;

  @override
  Future onLoad() async {
    position = game.player.muzzlePos;
    speed = initialSpeed;
    spriteImage = await Flame.images.load('bullet_pink.png');
    animation = spriteImage.getAnimation(
      size: Vector2(24, 24),
      frames: 4,
      stepTime: _animationStepTime,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 画面端に到達
    if (x + speed > _worldEdgeX) {
      removeFromParent();

      final fx = BulletFx(position: Vector2(_worldEdgeX + size.x / 2, y - size.y / 2));
      parent!.add(fx);
      onHit(this);
      return;
    }
    // ターゲットに接触
    if (x + speed > game.target.position.x) {
      final fx = BulletFx(position: Vector2(game.target.position.x + size.x / 2, y - size.y / 2));
      parent!.add(fx);
      removeFromParent();
      onHit(this);
    }

    x += speed;
    speed += accel;
    speed -= speed * friction;
  }
}
