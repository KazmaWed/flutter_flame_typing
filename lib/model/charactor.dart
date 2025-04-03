import '../extension/string_extension.dart';

enum CharactorType {
  alphabet,
  number,
  homePosKey,
  symbol,
}

extension CharactorTypeExtension on CharactorType {
  String values() {
    switch (this) {
      case CharactorType.alphabet:
        return 'abcdefghijklmnopqrstuvxxyz';
      case CharactorType.number:
        return '0123456789';
      case CharactorType.homePosKey:
        return 'fj';
      case CharactorType.symbol:
        return '!@#\$%^&*()-=_+[]{}\\|;:\'",.<>/?`~';
    }
  }

  String random() {
    return values().pickRandom();
  }
}
