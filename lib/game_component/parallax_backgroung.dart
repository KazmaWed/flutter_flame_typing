import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import '../game_component/player_state.dart';
import '../game/typing_game.dart';

class ParallaxBackgroung extends ParallaxComponent<TypingGame> {
  ParallaxBackgroung() : super();
  Vector2 lastPosition = Vector2.zero();

  final accel = Vector2(0.8, 0);
  final maxVelocity = Vector2(24, 0);

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    size = game.size;
    parallax = await game.loadParallax(
      [
        ParallaxImageData('parallax_bg.png'),
        ParallaxImageData('parallax_far_buildings.png'),
        ParallaxImageData('parallax_buildings.png'),
      ],
      size: game.size,
      baseVelocity: Vector2(0, 0),
      velocityMultiplierDelta: Vector2(1.4, 1.0),
      filterQuality: FilterQuality.none,
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.player.current == PlayerState.running) {
      if (parallax!.baseVelocity.x < maxVelocity.x) {
        parallax!.baseVelocity += accel;
      }
    } else {
      if (parallax!.baseVelocity.x > 0) {
        parallax!.baseVelocity -= accel;
      }
    }
  }
}
