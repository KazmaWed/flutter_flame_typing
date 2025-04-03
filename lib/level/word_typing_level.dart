import 'package:flutter_flame_typing/extension/list_extension.dart';
import 'package:flutter_flame_typing/model/word.dart';

import '../model/level.dart';

Level _autoGenShort(String title, Language language) {
  return Level(
    title: title,
    events: [
      Message.wave(1),
      for (var i = 0; i < 15; i++) Obstacle(language.extraShort().pickRandom()),
      Message.wave(2),
      for (var i = 0; i < 15; i++) Obstacle(language.short().pickRandom()),
    ],
  );
}

Level _autoGenMedium(String title, Language language) {
  return Level(
    title: title,
    events: [
      Message.wave(1),
      for (var i = 0; i < 15; i++) Obstacle(language.medium().pickRandom()),
      Message.wave(2),
      for (var i = 0; i < 15; i++) Obstacle(language.long().pickRandom()),
    ],
  );
}

Level _autoGenLong(String title, Language language) {
  return Level(
    title: title,
    events: [
      Message.wave(1),
      for (var i = 0; i < 15; i++) Obstacle(language.extraLong().pickRandom()),
      Message.wave(2),
      for (var i = 0; i < 15; i++) Obstacle(language.longest().pickRandom()),
    ],
  );
}

class WordPracticeLevel {
  static List<Level Function()> generators(
    Language language,
  ) {
    return [
      () => _autoGenShort('${language.name}(短)', language),
      () => _autoGenMedium('${language.name}(中)', language),
      () => _autoGenLong('${language.name}(長)', language),
    ];
  }
}
