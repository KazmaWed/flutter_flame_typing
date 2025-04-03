import 'dart:math';

extension StringExtension on String {
  String pickRandom() {
    final unique = split('').toSet();
    final id = Random().nextInt(unique.length);
    return unique.toList()[id];
  }

  String combineRandom(int count) {
    var output = '';
    for (var i = 0; i < count; i++) {
      output += pickRandom();
    }
    return output;
  }

  String charactors() {
    return split('').where((c) => alphabets.contains(c)).join('');
  }

  String get alphabets => 'abcdefghijklmnopqrstuvwxyz';
}
