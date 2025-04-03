import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../game_component/dust_fx.dart';
import '../game/typing_game.dart';
import '../model/game_phase.dart';
import '../extension/flame_image_extension.dart';
import 'player_state.dart';

class Player extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameReference<TypingGame>, CollisionCallbacks {
  Player() : super(size: Vector2(72, 72), anchor: Anchor.centerRight);

  double get floorY => position.y + size.y / 2;
  Vector2 get initialPosition => Vector2(-game.size.x / 2 + size.x * 1.5, 0);
  late final muzzlePos = Vector2(position.x + 50, position.y + 14); // プライヤーの銃口の高さ

  Vector2 speed = Vector2(0, 0);
  double runningTime = 0.0;
  double nextDustFx = 0.0;
  double clearIdle = 0;

  final flyingAccel = 0.4;
  final flyingBuoyancy = -0.20;
  final friction = 0.1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = initialPosition;
    final imageRun = await Flame.images.load('player_run.png');
    final imageIdle = await Flame.images.load('player_idle.png');
    final imageDying = await Flame.images.load('player_dying.png');
    final imageDead = await Flame.images.load('player_dead.png');
    final imageFlying = await Flame.images.load('player_flying.png');

    animations = {
      PlayerState.idle: imageIdle.getAnimation(
        size: Vector2(24, 24),
        frames: 4,
        stepTime: 0.2,
      ),
      PlayerState.running: imageRun.getAnimation(
        size: Vector2(24, 24),
        frames: 4,
      ),
      PlayerState.dying: imageDying.getAnimation(
        size: Vector2(24, 24),
        frames: 8,
        loop: false,
      ),
      PlayerState.dead: imageDead.getAnimation(
        size: Vector2(24, 24),
        frames: 1,
        loop: false,
      ),
      PlayerState.flying: imageFlying.getAnimation(
        size: Vector2(24, 24),
        frames: 3,
      ),
    };
    current = PlayerState.idle;
  }

  void reset() {
    nextDustFx = 0;
    position = initialPosition;
    speed = Vector2.zero();
    current = PlayerState.idle;
    clearIdle = 0;
  }

  @override
  void update(dt) {
    super.update(dt);
    switch (game.phase) {
      case GamePhase.playing:
        current = PlayerState.running;
      case GamePhase.starting:
        current = PlayerState.idle;
      case GamePhase.pause:
        current = PlayerState.idle;
      case GamePhase.gameover:
        current = PlayerState.dying;
      case GamePhase.clear:
        if (game.size.x / 2 < position.x - size.x) return;
        clearIdle += dt;
        if (clearIdle < 1.5) {
          current = PlayerState.idle;
        } else {
          current = PlayerState.flying;
          speed.x += flyingAccel;
          if (2.1 < clearIdle) speed.y += flyingBuoyancy;
          position += speed;
        }
    }
    if (current == PlayerState.running) {
      runningTime += dt;
      if (nextDustFx < runningTime) {
        game.world.add(DustFx());
        nextDustFx += 0.75 + Random().nextInt(1000) / 1000;
      }
    }
  }
}
