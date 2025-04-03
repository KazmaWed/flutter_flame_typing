import '../extension/string_extension.dart';
import '../model/kayboard_layout.dart';
import '../model/level.dart';

Level _autoGen(String title, KeyboardLayout layout, String charactors) {
  return Level(
    title: title,
    events: [
      Message(layout.name),
      Message.wave(1),
      for (var i = 0; i < 10; i++) Obstacle(charactors.combineRandom(1)),
      Message.wave(2),
      for (var i = 0; i < 10; i++) Obstacle(charactors.combineRandom(2)),
      Message.wave(3),
      for (var i = 0; i < 10; i++) Obstacle(charactors.combineRandom(3)),
    ],
  );
}

class PositionPracticeLevel {
  static List<Level Function()> levels({KeyboardLayout layout = KeyboardLayout.qwerty}) => [
        () => _autoGen('1列目のキー', layout, layout.keyMap.r1Charactors),
        () => _autoGen('2列目のキー', layout, layout.keyMap.r2Charactors),
        () => _autoGen('3列目のキー', layout, layout.keyMap.r3Charactors),
        () => _autoGen('右側のキー', layout, layout.keyMap.right),
        () => _autoGen('左側のキー', layout, layout.keyMap.left),
        () => _autoGen('内側のキー', layout, layout.keyMap.inner),
        () => _autoGen('外側のキー', layout, layout.keyMap.outer),
      ];
  static List<Level Function()> rows({KeyboardLayout layout = KeyboardLayout.qwerty}) => [
        () => _autoGen('1列目のキー', layout, layout.keyMap.r1Charactors),
        () => _autoGen('2列目のキー', layout, layout.keyMap.r2Charactors),
        () => _autoGen('3列目のキー', layout, layout.keyMap.r3Charactors),
      ];
  static List<Level Function()> sides({KeyboardLayout layout = KeyboardLayout.qwerty}) => [
        () => _autoGen('右側のキー', layout, layout.keyMap.right),
        () => _autoGen('左側のキー', layout, layout.keyMap.left),
        () => _autoGen('内側のキー', layout, layout.keyMap.inner),
        () => _autoGen('外側のキー', layout, layout.keyMap.outer),
      ];
}
