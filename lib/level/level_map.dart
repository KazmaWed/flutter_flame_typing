interface class GameMode {
  GameMode(this.title, this.id);
  final String title;
  final int id;

  static GameMode fromId(int id) {
    switch (id) {
      case 0:
        return PositionPracticeMode();
      default:
        return WordPracticeMode();
    }
  }
}

class PositionPracticeMode implements GameMode {
  @override
  int get id => 0;
  @override
  String get title => 'ポジション練習';
}

class WordPracticeMode implements GameMode {
  @override
  int get id => 1;
  @override
  String get title => 'ワード練習';
}
