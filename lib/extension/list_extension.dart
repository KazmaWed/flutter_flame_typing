import 'dart:math';

extension ListExtension on List {
  dynamic pickRandom() {
    final id = Random().nextInt(length);
    return this[id];
  }

  T? lastWhereOrNull<T>(bool Function(T) test) {
    for (var i = length - 1; i >= 0; i--) {
      if (test(this[i])) return this[i];
    }
    return null;
  }
}

extension StringIterableExtension on Iterable<String> {
  List<String> toLowerCaseList() {
    return map((e) => e.toLowerCase()).toList();
  }
}
