import '../extension/string_extension.dart';

class KeyRow {
  const KeyRow({
    required this.defaultLayer,
    required this.shiftLayer,
  });
  final String defaultLayer;
  final String shiftLayer;

  List<String> layers() {
    return [defaultLayer, shiftLayer];
  }
}

class KeyMap {
  const KeyMap({
    required this.r4,
    required this.r3,
    required this.r2,
    required this.r1,
  });
  final KeyRow r4;
  final KeyRow r3;
  final KeyRow r2;
  final KeyRow r1;
  String get r3Charactors => r3.defaultLayer.charactors();
  String get r2Charactors => r2.defaultLayer.charactors();
  String get r1Charactors => r1.defaultLayer.charactors();
  String get r1OuterL => r1.defaultLayer.substring(0, 2).charactors();
  String get r1OuterR => r1.defaultLayer.substring(8).charactors();
  String get r1Outer => r1OuterL + r1OuterR;
  String get r2OuterL => r2.defaultLayer.substring(0, 2).charactors();
  String get r2OuterR => r2.defaultLayer.substring(8).charactors();
  String get r2Outer => r2OuterL + r2OuterR;
  String get r3OuterL => r3.defaultLayer.substring(0, 2).charactors();
  String get r3OuterR => r3.defaultLayer.substring(8).charactors();
  String get r3Outer => r3OuterL + r3OuterR;
  String get outer => r1Outer + r2Outer + r3Outer;
  String get r1Inner => r1.defaultLayer.substring(2, 8).charactors();
  String get r2Inner => r2.defaultLayer.substring(2, 8).charactors();
  String get r3Inner => r3.defaultLayer.substring(2, 8).charactors();
  String get inner => r1Inner + r2Inner + r3Inner;
  String get r1L => r1.defaultLayer.substring(0, 5).charactors();
  String get r1R => r1.defaultLayer.substring(5).charactors();
  String get r2L => r2.defaultLayer.substring(0, 5).charactors();
  String get r2R => r2.defaultLayer.substring(5).charactors();
  String get r3L => r3.defaultLayer.substring(0, 5).charactors();
  String get r3R => r3.defaultLayer.substring(5).charactors();
  String get left => r1L + r2L + r3L;
  String get right => r1R + r2R + r3R;
}

class KeyboardLayout {
  final String name;
  final KeyMap keyMap;
  const KeyboardLayout({required this.name, required this.keyMap});

  List<KeyRow> get rows => [keyMap.r1, keyMap.r2, keyMap.r3, keyMap.r4];
  // String get outer => keyMap.r1.sup;

  static Map<String, KeyboardLayout> map = {
    qwerty.name: qwerty,
    colemak.name: colemak,
    dvorak.name: dvorak,
    onishi.name: onishi
  };

  static List<KeyboardLayout> get values => [qwerty, colemak, dvorak, onishi];

  static const qwerty = KeyboardLayout(
    name: 'Qwerty',
    keyMap: KeyMap(
      r4: KeyRow(defaultLayer: '`1234567890-=', shiftLayer: '~!@#\$%^&*()_+'),
      r3: KeyRow(defaultLayer: 'qwertyuiop[]\\', shiftLayer: 'QWERTYUIOP{}|'),
      r2: KeyRow(defaultLayer: 'asdfghjkl;\'', shiftLayer: 'ASDFGHJKL:"'),
      r1: KeyRow(defaultLayer: 'zxcvbnm,./', shiftLayer: 'ZXCVBNM<>?'),
    ),
  );
  static const colemak = KeyboardLayout(
    name: 'Colemak',
    keyMap: KeyMap(
      r4: KeyRow(defaultLayer: '`1234567890-=', shiftLayer: '~!@#\$%^&*()_+'),
      r3: KeyRow(defaultLayer: 'qwfpgjluy;[]\\', shiftLayer: 'QWFPGJLUY{}|'),
      r2: KeyRow(defaultLayer: 'arstdhneio\'', shiftLayer: 'ARSTDHNEIO"'),
      r1: KeyRow(defaultLayer: 'zxcvbkm,./', shiftLayer: 'ZXCVBKM<>?'),
    ),
  );
  static const dvorak = KeyboardLayout(
    name: 'Dvorak',
    keyMap: KeyMap(
      r4: KeyRow(defaultLayer: '`1234567890-=', shiftLayer: '~!@#\$%^&*()_+'),
      r3: KeyRow(defaultLayer: 'qwertyuiop[]\\', shiftLayer: 'QWERTYUIOP{}|'),
      r2: KeyRow(defaultLayer: 'asdfghjkl;\'', shiftLayer: 'ASDFGHJKL:"'),
      r1: KeyRow(defaultLayer: 'zxcvbnm,./', shiftLayer: 'ZXCVBNM<>?'),
    ),
  );
  static const onishi = KeyboardLayout(
    name: '024',
    keyMap: KeyMap(
      r4: KeyRow(defaultLayer: '`\\\'1234567890', shiftLayer: '~|"!@#\$%^&*()'),
      r3: KeyRow(defaultLayer: 'qlu,.fwryp[]/', shiftLayer: 'QLU<>FWRYP{}?'),
      r2: KeyRow(defaultLayer: 'eiao-ktnsh=', shiftLayer: 'EIAO_KTNSH+'),
      r1: KeyRow(defaultLayer: 'zxcv;gdmjb', shiftLayer: 'ZXCV:GDMJB'),
    ),
  );

  String keySwap(
    String string, {
    required KeyboardLayout to,
  }) {
    for (var r = 0; r < 4; r++) {
      for (var l = 0; l < 2; l++) {
        final layer = rows[r].layers()[l];
        for (var c = 0; c < layer.length; c++) {
          if (string == layer[c]) {
            return to.rows[r].layers()[l][c];
          }
        }
      }
    }
    return string;
  }
}

// extension KeyboardLayoutExtension on KeyboardLayout {
//   Set<LogicalKeyboardKey> get symbolKeys => {
//         LogicalKeyboardKey.backquote,
//         LogicalKeyboardKey.tilde,
//         LogicalKeyboardKey.exclamation,
//         LogicalKeyboardKey.at,
//         LogicalKeyboardKey.numberSign,
//         LogicalKeyboardKey.dollar,
//         LogicalKeyboardKey.percent,
//         LogicalKeyboardKey.caret,
//         LogicalKeyboardKey.ampersand,
//         LogicalKeyboardKey.asterisk,
//         LogicalKeyboardKey.parenthesisLeft,
//         LogicalKeyboardKey.parenthesisRight,
//         LogicalKeyboardKey.minus,
//         LogicalKeyboardKey.underscore,
//         LogicalKeyboardKey.equal,
//         LogicalKeyboardKey.add,
//         LogicalKeyboardKey.bracketLeft,
//         LogicalKeyboardKey.bracketRight,
//         LogicalKeyboardKey.braceLeft,
//         LogicalKeyboardKey.braceRight,
//         LogicalKeyboardKey.backslash,
//         LogicalKeyboardKey.bar,
//         LogicalKeyboardKey.semicolon,
//         LogicalKeyboardKey.colon,
//         LogicalKeyboardKey.quote,
//         LogicalKeyboardKey.quoteSingle,
//         LogicalKeyboardKey.comma,
//         LogicalKeyboardKey.less,
//         LogicalKeyboardKey.period,
//         LogicalKeyboardKey.greater,
//         LogicalKeyboardKey.slash,
//         LogicalKeyboardKey.question,
//       };
// }
