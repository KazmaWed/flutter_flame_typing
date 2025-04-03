import 'package:flutter_flame_typing/extension/list_extension.dart';

import 'english.dart';

class Word {
  final String spelling;

  Word({required this.spelling});
}

class Language {
  final String name;
  final List<String> words;

  const Language({
    required this.name,
    required this.words,
  });

  static const values = [japanese, english, program];

  List<String> extraShort() => words.where((e) => e.length <= 2).toLowerCaseList();
  List<String> short() => words.where((e) => 3 <= e.length && e.length <= 4).toLowerCaseList();
  List<String> medium() => words.where((e) => 5 <= e.length && e.length <= 6).toLowerCaseList();
  List<String> long() => words.where((e) => 7 <= e.length && e.length <= 8).toLowerCaseList();
  List<String> extraLong() => words.where((e) => 9 <= e.length && e.length <= 10).toLowerCaseList();
  List<String> longest() => words.where((e) => 11 <= e.length).toLowerCaseList();

  static const japanese = Language(name: '日本語', words: commonEnglish);
  static const english = Language(name: '英語', words: commonEnglish);
  static const program = Language(name: 'プログラミング言語', words: commonEnglish);
}

// enum WordType {
//   flutter,
//   symbol,
// }

// extension WordTypeExtension on WordType {
//   List<String> values() {
//     switch (this) {
//       case WordType.flutter:
//         return _flutterWords;
//       case WordType.symbol:
//         return _symbols;
//     }
//   }

//   String random() {
//     return values().pickRandom();
//   }
// }

// final List<String> _flutterWords = [
//   'late',
//   'get',
//   'final',
//   'const',
//   'var',
//   'for',
//   'if',
//   'try',
//   'catch',
//   'List',
//   'Set',
//   'Map',
//   'int',
//   'double',
//   'Bool',
//   'String',
// ];

// final List<String> _symbols = [
//   '()',
//   '[]',
//   '{}',
//   '==',
//   '!=',
//   '<=',
//   '>=',
//   '<>',
//   '++',
//   '--',
//   '+=',
//   '-=',
//   '*=',
//   '/=',
//   '~/',
//   '%',
//   '||',
//   '&&',
//   '\'\'',
//   ';',
//   '//',
//   '??',
// ];
