import '../model/level.dart';

final level00 = Level(
  title: 'Level 00',
  events: [Obstacle('f')],
);

final level01 = Level(
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

final level02 = Level(
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
