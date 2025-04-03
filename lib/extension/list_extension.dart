import 'dart:math';

extension ListExtension on List {
  dynamic pickRandom() {
    final id = Random().nextInt(length);
    return this[id];
  }
}

extension StringIterableExtension on Iterable<String> {
  List<String> toLowerCaseList() {
    return map((e) => e.toLowerCase()).toList();
  }
}
