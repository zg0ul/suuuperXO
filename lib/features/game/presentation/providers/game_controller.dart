import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuuperxo/features/game/data/repositories/game_repository.dart';
import 'package:suuuperxo/features/game/domain/models/game_state.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  @override
  GameState build() {
    return GameState.initial(); // Initial empty game
  }

  void makeMove(int boardIndex, int cellIndex) {
    final repo = ref.read(gameRepositoryProvider);

    // Validate first
    if (!repo.isValidMove(state, boardIndex, cellIndex)) {
      // Show error or just return
      return;
    }

    // Apply the move
    state = repo.makeMove(state, boardIndex, cellIndex);
  }
}
