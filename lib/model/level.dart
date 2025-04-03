abstract class Event {}

class Obstacle extends Event {
  Obstacle(this.word, {this.durationMillisec = 2000});
  final String word;
  final int durationMillisec;
}

class Message extends Event {
  Message(this.value);
  final String value;

  static Message ready() => Message('Ready?');
  static Message wave(int i) => Message('Wave $i');
}

class Level {
  const Level({
    required this.title,
    required this.events,
  });
  final String title;
  final List<Event> events;
}
