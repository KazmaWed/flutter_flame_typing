enum GameScoreClass {
  f('ひよこタイパー', 1),
  e('うさぎタイパー', 2),
  d('駆け出しタイパー', 3),
  c('快速タイパー', 4),
  b('音速タイパー', 5),
  a('光速タイパー', 6),
  s('ニンジャタイパー', 7);

  const GameScoreClass(this.title, this.level);
  final String title;
  final int level;

  factory GameScoreClass.fromScore(int score) {
    for (var value in GameScoreClass.values) {
      if (score < value.level * 50) {
        return value;
      }
    }
    return GameScoreClass.s;
  }
}
