import '../model/game_phase.dart';
import '../model/game_score.dart';

mixin TypingGameState {
  double distance = 0;
  String? word;
  GamePhase phase = GamePhase.starting;
  late GameScore score;

  void resetState() {
    distance = 0;
    phase = GamePhase.starting;
  }
}
