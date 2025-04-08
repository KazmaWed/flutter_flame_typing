import 'package:freezed_annotation/freezed_annotation.dart';

import '../extension/list_extension.dart';
import 'level.dart';

part 'game_score.freezed.dart';

// Levelプレイ中のスコアを管理するクラス
@freezed
abstract class GameScore with _$GameScore {
  const GameScore._();
  const factory GameScore({
    required Level level,
    required Map<Obstacle, ObstacleScore> obstacleScore,
  }) = _GameScore;

  // ---------- ゲッター類 ----------

  Event? get currentEvent => level.events.firstWhere((e) => e.end == false);
  int? get currentEventIndex {
    for (var i = 0; i < level.events.length; i++) {
      if (level.events[i].end == false) {
        return i;
      }
    }
    return null;
  }

  Obstacle? get currentObstacle =>
      currentObstacleIndex == null ? null : level.obstacles[currentObstacleIndex!];
  int? get currentObstacleIndex {
    for (var i = 0; i < level.obstacles.length; i++) {
      if (level.obstacles[i].end == false) {
        return i;
      }
    }
    return null;
  }

  int get totalCorrectType => obstacleScore.values.fold(0, (sum, e) => sum + e.correct); // 正解数
  int get totalIncorrectType => obstacleScore.values.fold(0, (sum, e) => sum + e.incorrect); // 正解数

  // 生成メソッド
  static GameScore createGameScore(Level level) {
    return GameScore(
      level: level,
      obstacleScore: {
        for (final obstacle in level.events.whereType<Obstacle>())
          obstacle: ObstacleScore(obstacle.word)
      },
    );
  }

  // 全ての単語終了
  bool get clear => level.events.every((e) => e.end); // 全ての単語をタイプしたか
  // 失敗なしでクリア
  bool get perfect => clear && totalIncorrectType == 0; // ノーミスでクリアしたか

  // 直近の連続正解数
  int get combo {
    final Obstacle? lastObstacle =
        level.obstacles.lastWhereOrNull((e) => obstacleScore[e]?.notStarted == false);
    if (lastObstacle == null) return 0;

    final lastObstacleIndex = obstacleScore.keys.toList().indexOf(lastObstacle);
    int count = 0;
    for (var i = lastObstacleIndex; i >= 0; i--) {
      final obstacle = level.obstacles[i];
      if (obstacleScore[obstacle]?.perfect == true) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  // ---------- 更新メソッド類 ----------

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
    return copyWith(
      obstacleScore: obstacleScore.map((key, value) {
        if (key == (obstacle ?? currentObstacle)) {
          return MapEntry(
              key, ObstacleScore(key.word, correct: value.correct + 1, incorrect: value.incorrect));
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
        if (key == obstacle) {
          return MapEntry(key, ObstacleScore(key.word, correct: value.incorrect + 1));
        }
        return MapEntry(key, value);
      }),
    );
  }

  @override
  String toString() {
    return 'GameScore(event: $currentEventIndex, correct: $totalCorrectType, incorrect: $totalIncorrectType, combo: $combo, perfect: $perfect)';
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
}
