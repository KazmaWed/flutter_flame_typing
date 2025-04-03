import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../model/game_color.dart';

class ParallaxBackgroundView extends StatelessWidget {
  const ParallaxBackgroundView({
    super.key,
    required this.gameSize,
  });
  final Vector2 gameSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: gameSize.x,
        height: gameSize.y,
        child: GameWidget(
          game: ParallaxBackgroundGame(
            gameSize: gameSize,
          ),
        ),
      ),
    );
  }
}

class ParallaxBackgroundGame extends FlameGame {
  ParallaxBackgroundGame({
    required this.gameSize,
  }) : size = gameSize;

  final Vector2 gameSize;

  @override
  Vector2 size;
  @override
  Color backgroundColor() => GameColor.gameBackgroung;

  // コンポーネント
  late final parallax = ParallaxBackgroung();

  @override
  Future<void> onLoad() async {
    world.add(parallax);
  }
}

class ParallaxBackgroung extends ParallaxComponent<ParallaxBackgroundGame> {
  ParallaxBackgroung() : super();
  Vector2 lastPosition = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    parallax = await game.loadParallax(
      [
        ParallaxImageData('parallax_bg.png'),
        ParallaxImageData('parallax_far_buildings.png'),
        ParallaxImageData('parallax_buildings.png'),
        ParallaxImageData('floor03.png'),
      ],
      size: game.size,
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 1.0),
      filterQuality: FilterQuality.none,
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = -10;
  }
}
