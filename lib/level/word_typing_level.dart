import 'package:ninja_typer/extension/list_extension.dart';
import 'package:ninja_typer/model/word.dart';

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
  // static List<Level Function()> generators(
  //   Language language,
  // ) {
  //   return [
  //     () => _autoGenShort('${language.name}(短)', language),
  //     () => _autoGenMedium('${language.name}(中)', language),
  //     () => _autoGenLong('${language.name}(長)', language),
  //   ];
  // }

  static List<Level Function()> english() {
    return [
      () => _autoGenShort('${Language.english.name}-短', Language.english),
      () => _autoGenMedium('${Language.english.name}-中', Language.english),
      () => _autoGenLong('${Language.english.name}-長', Language.english),
    ];
  }

  static List<Level Function()> program() {
    return [
      () => Level(
            title: '${Language.program.name}-短',
            events: [
              Message.wave(1),
              for (var i = 0; i < 15; i++) Obstacle(Language.program.ofLength(0, 3).pickRandom()),
              Message.wave(2),
              for (var i = 0; i < 15; i++) Obstacle(Language.program.ofLength(4, 5).pickRandom()),
            ],
          ),
      () => Level(
            title: '${Language.program.name}-長',
            events: [
              Message.wave(1),
              for (var i = 0; i < 15; i++) Obstacle(Language.program.ofLength(5, 6).pickRandom()),
              Message.wave(2),
              for (var i = 0; i < 15; i++) Obstacle(Language.program.ofLength(7, 100).pickRandom()),
            ],
          ),
    ];
  }
}
