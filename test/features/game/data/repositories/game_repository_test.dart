// In test/features/game/data/repositories/game_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:suuuperxo/features/game/data/repositories/game_repository.dart';
import 'package:suuuperxo/features/game/domain/models/game_state.dart';
import 'package:suuuperxo/features/game/domain/models/board_state.dart';
import 'package:suuuperxo/features/game/domain/models/cell_state.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';

void main() {
  late GameRepository repository;

  setUp(() {
    repository = GameRepository();
  });

  group('isValidMove', () {
    test('returns true for valid move in empty game', () {
      // Arrange
      final state = GameState.initial();

      // Act
      final result = repository.isValidMove(state, 0, 0);

      // Assert
      expect(result, true);
    });

    test('returns false when cell is already occupied', () {
      // Arrange
      final state = GameState.initial().copyWith(
        boards: [
          BoardState.initial().copyWith(
            cells: [
              const CellState(owner: Player.playerOne), // Cell 0 occupied
              ...List.generate(8, (_) => CellState.initial()),
            ],
          ),
          ...List.generate(8, (_) => BoardState.initial()),
        ],
      );

      // Act
      final result = repository.isValidMove(state, 0, 0);

      // Assert
      expect(result, false);
    });

    test('returns false when board is already won', () {
      // Arrange
      final state = GameState.initial().copyWith(
        boards: [
          BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
          ...List.generate(8, (_) => BoardState.initial()),
        ],
      );

      // Act
      final result = repository.isValidMove(state, 0, 0);

      // Assert
      expect(result, false);
    });

    test('returns false when game is finished', () {
      // Arrange
      final state = GameState.initial().copyWith(status: GameStatus.finished, winner: Player.playerOne);

      // Act
      final result = repository.isValidMove(state, 0, 0);

      // Assert
      expect(result, false);
    });

    test('enforces nextBoardIndex when target board is active', () {
      // Arrange
      final state = GameState.initial().copyWith(
        nextBoardIndex: 5, // Must play in board 5
      );

      // Act
      final resultCorrectBoard = repository.isValidMove(state, 5, 0);
      final resultWrongBoard = repository.isValidMove(state, 2, 0);

      // Assert
      expect(resultCorrectBoard, true);
      expect(resultWrongBoard, false);
    });

    test('allows any board when nextBoardIndex points to completed board', () {
      // Arrange
      final state = GameState.initial().copyWith(
        nextBoardIndex: 7,
        boards: [
          ...List.generate(7, (_) => BoardState.initial()),
          BoardState.initial().copyWith(
            status: BoardStatus.wonByPlayerOne, // Board 7 is won
          ),
          BoardState.initial(),
        ],
      );

      // Act
      final result = repository.isValidMove(state, 2, 0); // Try different board

      // Assert
      expect(result, true); // Should allow it
    });
  });
}
