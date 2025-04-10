import '../model/game_phase.dart';
import '../model/game_score.dart';

mixin TypingGameState {
  String? word;
  GamePhase phase = GamePhase.starting;
  late GameScore score;

  void resetState() {
    phase = GamePhase.starting;
  }
}
