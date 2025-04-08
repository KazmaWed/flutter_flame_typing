// Level中のイベント
abstract class Event {
  Event({this.end = false});
  bool end;

  Event copyWith({bool? end});
}

// 単語
class Obstacle extends Event {
  Obstacle(this.word, {super.end});

  final String word;

  int get length => word.length;

  @override
  Obstacle copyWith({String? word, bool? end}) {
    return Obstacle(
      word ?? this.word,
      end: end ?? this.end,
    );
  }
}

// ウェーブ間などのテキストイベント
class Message extends Event {
  Message(this.value, {super.end});

  final String value;

  static Message ready() => Message('Ready?');
  static Message wave(int i) => Message('Wave $i');

  @override
  Message copyWith({String? value, bool? end}) {
    return Message(
      value ?? this.value,
      end: end ?? this.end,
    );
  }

  @override
  String toString() {
    return 'Message($value)';
  }
}

// イベントを含むレベル
class Level {
  const Level({
    required this.title,
    required this.events,
  });
  final String title;
  final List<Event> events;

  List<Obstacle> get obstacles => events.whereType<Obstacle>().toList();

  // 出題単語数
  int get length => obstacles.length;
  // 出題単語の合計文字数
  int get totalCharactors => obstacles.fold(0, (sum, e) => sum + e.length);
}
