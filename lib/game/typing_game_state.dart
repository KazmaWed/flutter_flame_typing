import '../model/level.dart';
import '../model/game_phase.dart';

mixin TypingGameState {
  Event? event;
  String? word;
  int typed = 0;
  int score = 0;
  int count = 0;
  double distance = 0;
  GamePhase phase = GamePhase.starting;

  void resetState() {
    event = null;
    word = null;
    typed = 0;
    score = 0;
    count = 0;
    distance = 0;
    phase = GamePhase.starting;
  }
}
