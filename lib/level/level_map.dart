import 'package:flutter_flame_typing/level/position_practice_level.dart';
import 'package:flutter_flame_typing/model/level.dart';

final levels = <int, List<Level Function()>>{
  PositionPracticeMode().id: PositionPracticeLevel.levels(),
  WordTypePracticeMode().id: [],
};

interface class GameMode {
  GameMode(this.title, this.id);
  final String title;
  final int id;

  static GameMode fromId(int id) {
    switch (id) {
      case 0:
        return PositionPracticeMode();
      case 1:
        return WordTypePracticeMode();
      default:
        return TestTypeMode();
    }
  }
}

class PositionPracticeMode implements GameMode {
  @override
  int get id => 0;
  @override
  String get title => 'ポジション練習';
}

class WordTypePracticeMode implements GameMode {
  @override
  int get id => 1;
  @override
  String get title => 'ワードタイプ練習';
}

class TestTypeMode implements GameMode {
  @override
  int get id => 2;
  @override
  String get title => 'テストタイプ';
}
