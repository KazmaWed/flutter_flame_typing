import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/image_composition.dart';

import '../extension/flame_image_extension.dart';
import '../game/typing_game.dart';
import '../model/level.dart';
import '../model/game_phase.dart';

import 'target_fx.dart';

class Target extends SpriteAnimationComponent with HasGameReference<TypingGame> {
  Target({
    super.position,
    required this.id,
    required this.onHitPlayer,
    this.infiniteMode = false,
  }) : super(size: Vector2(90, 90), anchor: Anchor.centerLeft);

  int id;
  final Function onHitPlayer;
  final bool infiniteMode;

  late final Image spriteImage;
  final _animationStepTime = 0.12;

  final initialSpeed = 30.0;
  final baseAccel = 0.4;
  final extraAccel = 0.1;
  final friction = 0.18;

  late double speed;

  void init({required int newId}) {
    speed = initialSpeed;
    position = Vector2(game.size.x / 2, game.player.position.y);
    id = newId;
  }

  void vanish() {
    speed = 0;
    position = Vector2(game.size.x / 2, game.player.position.y);
  }

  @override
  Future onLoad() async {
    init(newId: 0);
    spriteImage = await Flame.images.load('bullet_plasma.png');
    animation = spriteImage.getAnimation(
      size: Vector2(30, 30),
      frames: 3,
      stepTime: _animationStepTime,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (game.phase != GamePhase.playing) return;
    if (game.level.events[game.count] is Message) return;

    // プレイヤー到達
    if (x < game.player.position.x) {
      fx();
      vanish();
      onHitPlayer();
      return;
    }

    // 画面端到達
    if (x < -game.size.x / 2) {
      init(newId: id);
      return;
    }

    // 座標計算
    x -= speed;
    speed += baseAccel;
    if (infiniteMode) speed += extraAccel * game.count;
    speed -= speed * friction;
  }

  void fx() {
    final fx = TargetFx(position: position + Vector2(-10, 0));
    parent!.add(fx);
  }
}
