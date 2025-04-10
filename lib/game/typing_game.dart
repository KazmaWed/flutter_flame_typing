import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_typing/game/game_score_component.dart';
import 'package:get_it/get_it.dart';

import '../game_component/bullet.dart';
import '../game_component/dying_fx.dart';
import '../game_component/life_bar.dart';
import '../game_component/parallax_backgroung.dart';
import '../game_component/player.dart';
import '../game_component/target.dart';
import '../model/game_audio.dart';
import '../model/game_phase.dart';
import '../model/game_color.dart';
import '../model/game_score.dart';
import '../model/game_setting_manager.dart';
import '../model/level.dart';
import '../game/typing_game_horizon.dart';
import '../game/typing_game_state.dart';
import '../game/typing_game_ui_overlay.dart';

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

  // ゲームスコアの状態
  Event get currentEvent => level.events[currentEventIndex];
  int get currentEventIndex => score.currentEventIndex;
  Obstacle get currentObstacle => score.currentObstacle;
  int get currentObstacleIndex => score.currentObstacleIndex;
  ObstacleScore? get currentObstacleScore => score.obstacleScore[currentObstacle];

  // その他オーディオやコンポーネントなど
  final audio = GetIt.instance.get<GameAudioPlayer>();
  final settingManager = GetIt.instance.get<GameSettingManager>();
  late var setting = settingManager.gameSetting;

  // コンポーネント
  late final parallax = ParallaxBackgroung();
  late final horizon = Horizon();
  late final player = Player();
  late final target = Target(id: currentObstacleIndex, onHitPlayer: () => _targetHitPlayer());
  late final textOverlay = TextOverlay();
  late LifeBar lifeBar;

  @override
  void onDispose() {
    super.onDispose();
    audio.stopBgm();
  }

  @override
  Future<void> onLoad() async {
    score = GameScore.createGameScore(level);
    world.add(parallax);
    world.add(horizon);
    world.add(player);
    world.add(target);
    world.add(textOverlay);

    _gameStart();
    if (bgm) audio.bgm();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (phase != GamePhase.playing) return KeyEventResult.ignored;
    if (currentEvent is! Obstacle) return KeyEventResult.ignored;

    // `KeyDownEvent`のみ処理
    if (event is KeyDownEvent && event.character != null) {
      final charactor = setting.virtualMode
          ? setting.phisicalLayout.keySwap(event.character!, to: setting.logicalLayout!)
          : event.character;
      if (charactor == currentObstacle.word[score.currentObstacleScore?.correct ?? 0]) {
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
    if (currentEvent is Obstacle) {
      score = score.copyWith(time: score.time + dt);
    }
  }

  void _gameStart() {
    phase = GamePhase.starting;
    Future.delayed(
      const Duration(milliseconds: 1500),
    ).then(
      (_) => proccessElement(),
    );
  }

  void _onCollect() {
    audio.play(GameAudio.shoot, setting.se);
    score = score.correctType();
    _shoot();
  }

  void _onWrond() {
    audio.play(GameAudio.wrong, setting.se);
    score = score.incorrectType();
  }

  void _clear() {
    phase = GamePhase.clear;
    word = 'CLEAR!';
    world.add(GameScoreComponent(score: score));
  }

  void proccessElement() async {
    phase = GamePhase.playing;
    final e = currentEvent;
    if (e is Message) {
      word = e.value;
      await Future.delayed(
        const Duration(milliseconds: 1500),
      ).then(
        (_) {
          score.endEvent(e);
          proccessElement();
        },
      );
    } else if (e is Obstacle) {
      target.init(newId: currentEventIndex);
      word = e.word;
      lifeBar = LifeBar(max: e.word.length.toDouble());
      world.add(lifeBar);
    }
  }

  void _shoot() {
    final bullet = Bullet(
      id: currentEventIndex,
      critical: currentObstacleScore?.clear ?? false,
      onHit: (bullet) => _bulletHitTarget(bullet),
    );
    world.add(bullet);
  }

  void _bulletHitTarget(Bullet bullet) {
    target.fx();
    audio.play(GameAudio.hit, setting.se);
    if (phase != GamePhase.playing) return;
    if (bullet.id == target.id) {
      lifeBar.damage();
    }

    if (bullet.critical && bullet.id == target.id) {
      score.endEvent(score.currentEvent);
      target.init(newId: currentEventIndex + 1);
      Future.delayed(const Duration(milliseconds: 200)).then(
        (_) {
          audio.play(GameAudio.reload, setting.se);
        },
      );
      if (!score.clear) {
        proccessElement();
      } else {
        _clear();
      }
    }
  }

  void _targetHitPlayer() async {
    phase = GamePhase.gameover;
    audio.play(GameAudio.dying, setting.se);
    for (var i = 0; i < 6; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      world.add(DyingFx());
    }
    world.add(GameScoreComponent(score: score));
  }
}
