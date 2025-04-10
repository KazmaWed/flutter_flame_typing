import '../extension/list_extension.dart';
import 'english.dart';
import 'programing_keyword.dart';

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

  static const values = [
    // japanese,
    english,
    program,
  ];

  List<String> ofLength(int min, int max) =>
      words.where((e) => min <= e.length && e.length <= max).toLowerCaseList();
  List<String> extraShort() => words.where((e) => e.length <= 2).toLowerCaseList();
  List<String> short() => words.where((e) => 3 <= e.length && e.length <= 4).toLowerCaseList();
  List<String> medium() => words.where((e) => 5 <= e.length && e.length <= 6).toLowerCaseList();
  List<String> long() => words.where((e) => 7 <= e.length && e.length <= 8).toLowerCaseList();
  List<String> extraLong() => words.where((e) => 9 <= e.length && e.length <= 10).toLowerCaseList();
  List<String> longest() => words.where((e) => 11 <= e.length).toLowerCaseList();

  // static const japanese = Language(name: '日本語', words: commonEnglish);
  static const english = Language(name: '英単語', words: commonEnglish);
  static const program = Language(name: 'プログラミング', words: programingKeywords);
}

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
