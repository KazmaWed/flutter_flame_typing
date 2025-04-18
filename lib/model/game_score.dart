import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../extension/list_extension.dart';
import 'app_info.dart';
import 'level.dart';

part 'game_score.freezed.dart';

// Levelプレイ中のスコアを管理するクラス
@freezed
abstract class GameScore with _$GameScore {
  const GameScore._();
  const factory GameScore({
    required double time,
    required Level level,
    required Map<Obstacle, ObstacleScore> obstacleScore,
  }) = _GameScore;

  // 生成メソッド
  static GameScore createGameScore(Level level) {
    return GameScore(
      time: 0,
      level: level,
      obstacleScore: {
        for (final obstacle in level.events.whereType<Obstacle>())
          obstacle: ObstacleScore(obstacle.word)
      },
    );
  }

  @override
  String toString() {
    return 'GameScore(event: $currentEventIndex, correct: $totalCorrectType, incorrect: $totalIncorrectType, combo: $combo, perfect: $perfect, time: $time)';
  }
}

// 単語ごとのスコアを管理するクラス
class ObstacleScore {
  ObstacleScore(this.word, {this.correct = 0, this.incorrect = 0});
  final String word;
  final int correct;
  final int incorrect;

  bool get notStarted => correct == 0 && incorrect == 0; // まだタイピングしていないか
  bool get clear => correct == word.length; // 単語をタイプしたか
  bool get noMissYet => incorrect == 0; // ミスをしていないか (クリア前でもtrue)
  bool get perfect => correct == word.length && incorrect == 0; // ノーミスでクリアしたか

  ObstacleScore copyWith({
    String? word,
    int? correct,
    int? incorrect,
  }) {
    return ObstacleScore(
      word ?? this.word,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'correct': correct,
      'incorrect': incorrect,
      'clear': clear,
      'perfect': perfect,
    };
  }
}

// GameScoreの拡張メソッド群
extension GameScoreExtension on GameScore {
  // ---------- ゲッター類 ----------

  Event get currentEvent =>
      level.events.firstWhereOrNull((e) => e.end == false) ?? level.events.last;
  int get currentEventIndex => level.events.indexOf(currentEvent);

  Obstacle get currentObstacle =>
      level.obstacles.firstWhereOrNull((e) => e.end == false) ?? level.obstacles.last;
  int get currentObstacleIndex => level.obstacles.indexOf(currentObstacle);

  ObstacleScore? get currentObstacleScore => obstacleScore[currentObstacle];

  int get totalCorrectType => obstacleScore.values.fold(0, (sum, e) => sum + e.correct); // 正解数
  int get totalIncorrectType => obstacleScore.values.fold(0, (sum, e) => sum + e.incorrect); // 正解数
  double get accuracy => 100 * totalCorrectType / (totalCorrectType + totalIncorrectType); // 正解率
  double get lpm => totalCorrectType / time * 60; // 単位時間あたりの正解数

  // 全ての単語が終了したか
  bool get clear => level.events.every((e) => e.end); // 全ての単語をタイプしたか
  // 失敗なしでクリアしたか
  bool get perfect => clear && totalIncorrectType == 0; // ノーミスでクリアしたか

  // 直近の連続正解数
  int get combo {
    if (currentObstacleIndex == 0) return 0;
    final lastObstacleIndex = currentObstacleIndex - 1;

    int count = 0;
    for (var i = lastObstacleIndex; i >= 0; i--) {
      final obstacle = obstacleScore.keys.toList()[i];
      if (obstacleScore[obstacle]!.perfect == true) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  int get maxCombo {
    int max = 0;
    int currentCount = 0;

    for (bool value in obstacleScore.values.map((e) => e.perfect)) {
      if (value) {
        currentCount++;
        max = currentCount > max ? currentCount : max;
      } else {
        currentCount = 0;
      }
    }

    return max;
  }

  // ---------- 変換メソッド類 ----------

  // Firebase Cloud Store格納用Json
  Map<String, dynamic> toJson({AppInfo? appInfo}) {
    return {
      'debug': kDebugMode,
      'uuid': (appInfo ?? AppInfo()).uuid,
      'appVersion': (appInfo ?? AppInfo()).appVersion,
      'dateTime': DateTime.now().toIso8601String(),
      'level': level.title,
      'clear': clear,
      'time': time,
      'accuracy': accuracy,
      'lpm': lpm,
      'maxCombo': maxCombo,
      'obstacleScore': obstacleScore.values.where((e) => e.clear).map((e) => e.toJson()).toList(),
    };
  }

  // ---------- 複製メソッド類 ----------

  // イベントの終了フラグを立てる
  GameScore endEvent(Event? on) {
    for (var i = 0; i < level.events.length; i++) {
      final event = level.events[i];
      if (on == event) {
        level.events[i] = event.copyWith(end: true);
        break;
      }
    }
    return this;
  }

  // 単語で正解をタイピング
  GameScore correctType({Obstacle? obstacle}) {
    final score = obstacleScore[obstacle ?? currentObstacle];
    if (score?.clear == true) return this;

    return copyWith(
      obstacleScore: obstacleScore.map((key, value) {
        if (key == (obstacle ?? currentObstacle)) {
          return MapEntry(key, score!.copyWith(correct: value.correct + 1));
        }
        return MapEntry(key, value);
      }),
    );
  }

  // 単語で不正解をタイピング
  GameScore incorrectType({Obstacle? obstacle}) {
    final score = obstacleScore[obstacle ?? currentObstacle];
    if (score?.clear == true) return this;

    return copyWith(
      obstacleScore: obstacleScore.map((key, value) {
        if (key == (obstacle ?? currentObstacle)) {
          return MapEntry(key, score!.copyWith(incorrect: value.incorrect + 1));
        }
        return MapEntry(key, value);
      }),
    );
  }
}
