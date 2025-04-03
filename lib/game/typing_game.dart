import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../game_component/bullet.dart';
import '../game_component/dying_fx.dart';
import '../game_component/game_audio.dart';
import '../game_component/life_bar.dart';
import '../game_component/parallax_backgroung.dart';
import '../game_component/player.dart';
import '../game_component/target.dart';
import '../model/game_phase.dart';
import '../model/game_color.dart';
import '../model/game_setting_manager.dart';
import '../model/level.dart';
import '../game/typing_game_horizon.dart';
import '../game/typing_game_state.dart';
import 'typing_game_ui_overlay.dart';

class TypingGame extends FlameGame
    with KeyboardEvents, TapCallbacks, HasCollisionDetection, TypingGameState {
  TypingGame({
    required this.gameSize,
    required this.level,
    required this.bgm,
    required this.onTapQuit,
  }) : size = gameSize;

  final Vector2 gameSize;
  final Level level;
  final bool bgm;
  final Function onTapQuit;

  @override
  Vector2 size;
  @override
  Color backgroundColor() => GameColor.gameBackgroung;

  final audio = GetIt.instance.get<GameAudio>();
  final settingManager = GetIt.instance.get<GameSettingManager>();
  late var setting = settingManager.gameSetting;

  // コンポーネント
  late final parallax = ParallaxBackgroung();
  late final horizon = Horizon();
  late final player = Player();
  late final target = Target(id: count, onHitPlayer: () => _targetHitPlayer());
  late final textOverlay = TextOverlay();
  late LifeBar lifeBar;

  @override
  void onDispose() {
    super.onDispose();
    audio.stopBgm();
  }

  @override
  Future<void> onLoad() async {
    world.add(parallax);
    world.add(horizon);
    world.add(player);
    world.add(target);
    world.add(textOverlay);

    gameStart();
    if (bgm) audio.bgm();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (phase != GamePhase.playing) return KeyEventResult.ignored;
    if (level.events[count] is! Obstacle) return KeyEventResult.ignored;

    // `KeyDownEvent`のみ処理
    if (event is KeyDownEvent && event.character != null) {
      final charactor = setting.virtualMode
          ? setting.phisicalLayout.keySwap(event.character!, to: setting.logicalLayout!)
          : event.character;
      if (charactor == word?[typed]) {
        // 他のキーが押され続けている場合を除外
        _onCollect();
        return KeyEventResult.handled; // イベントを処理した場合
      } else if (event.character != null) {
        _onWrond();
      }
    }
    // 他のケースはイベントをスルー
    return KeyEventResult.ignored;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (phase != GamePhase.playing) return;
    if (level.events[count] is Obstacle) {
      distance += dt;
    }
  }

  void gameStart() {
    phase = GamePhase.starting;
    Future.delayed(
      const Duration(milliseconds: 1500),
    ).then(
      (_) => proccessElement(),
    );
  }

  void _onCollect() {
    if (setting.se ?? false) audio.shoot.start();
    typed += 1;
    _shoot();
  }

  void _onWrond() {
    if (setting.se ?? false) audio.wrong.start();
  }

  void proccessElement() async {
    phase = GamePhase.playing;
    final e = level.events[count];
    if (e is Message) {
      word = e.value;
      await Future.delayed(
        const Duration(milliseconds: 1500),
      ).then(
        (_) {
          count += 1;
          proccessElement();
        },
      );
    } else if (e is Obstacle) {
      target.init(newId: count);
      word = e.word;
      lifeBar = LifeBar(max: e.word.length.toDouble());
      world.add(lifeBar);
    }
  }

  void _shoot() {
    final bullet = Bullet(
      id: int.parse(count.toString()),
      critical: typed == word?.length,
      onHit: (bullet) => _bulletHitTarget(bullet),
    );
    world.add(bullet);
  }

  void _bulletHitTarget(Bullet bullet) {
    target.fx();
    if (setting.se ?? false) audio.hit.start();
    if (phase != GamePhase.playing) return;
    if (bullet.id == target.id) {
      score += 1;
      lifeBar.damage();
    }
    if (bullet.critical && bullet.id == target.id) {
      count += 1;
      typed = 0;
      target.init(newId: count);
      Future.delayed(const Duration(milliseconds: 200)).then(
        (_) {
          if (setting.se ?? false) audio.reload.start();
        },
      );
      if (level.events.length > count) {
        proccessElement();
      } else {
        phase = GamePhase.clear;
        word = 'CLEAR!';
      }
    }
  }

  void _targetHitPlayer() async {
    phase = GamePhase.gameover;
    if (setting.se ?? false) audio.dying.start(volume: 0.5);
    for (var i = 0; i < 6; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      world.add(DyingFx());
    }
  }
}
