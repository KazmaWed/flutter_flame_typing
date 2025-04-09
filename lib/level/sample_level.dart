import '../model/level.dart';

class SampleLavel {
  static List<Level Function()> get generators => [
        () => level00,
        () => level01,
        () => level02,
      ];
  static Level get level00 => Level(
        title: 'TestLevel',
        events: [
          Obstacle('asdf'),
          Obstacle('jkl;'),
          Obstacle('jjjjjjjj'),
        ],
      );

  static Level get level01 => Level(
        title: 'Level 01',
        events: [
          Message('母音タイピング'),
          Message.wave(1),
          Message.ready(),
          Obstacle('a'),
          Obstacle('i'),
          Obstacle('u'),
          Obstacle('e'),
          Obstacle('o'),
          Message.wave(2),
          Message.ready(),
          Obstacle('ai'),
          Obstacle('iu'),
          Obstacle('ue'),
          Obstacle('eo'),
          Obstacle('oa'),
          Message.wave(3),
          Message.ready(),
          Obstacle('aoi'),
          Obstacle('ieo'),
          Obstacle('eiu'),
          Obstacle('oae'),
          Obstacle('uoa'),
        ],
      );

  static Level get level02 => Level(
        title: 'Level 02',
        events: [
          Message('プログラミング 1'),
          Message.wave(1),
          Message.ready(),
          Obstacle('if'),
          Obstacle('for'),
          Obstacle('while'),
          Obstacle('catch'),
          Obstacle('error'),
          Message.wave(2),
          Message.ready(),
          Obstacle('bool'),
          Obstacle('float'),
          Obstacle('double'),
          Obstacle('integer'),
          Obstacle('String'),
          Message.wave(3),
          Message.ready(),
          Obstacle('function'),
          Obstacle('abstruct'),
          Obstacle('interface'),
          Obstacle('extension'),
          Obstacle('viewmodel'),
        ],
      );
}
