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
      final state = GameState.initial().copyWith(status: GameStatus.playing, result: GameResult.wonByPlayerOne);

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

  group('checkBoardWinner', () {
    group('Player One wins', () {
      test('detects row 0 win (top row)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });

      test('detects row 1 win (middle row)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });

      test('detects row 2 win (bottom row)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });

      test('detects column 0 win (left column)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });

      test('detects column 1 win (middle column)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });

      test('detects column 2 win (right column)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });

      test('detects main diagonal win (top-left to bottom-right)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });

      test('detects anti-diagonal win (top-right to bottom-left)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerOne);
      });
    });

    group('Player Two wins', () {
      test('detects row 0 win (top row)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });

      test('detects row 1 win (middle row)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });

      test('detects row 2 win (bottom row)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });

      test('detects column 0 win (left column)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });

      test('detects column 1 win (middle column)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });

      test('detects column 2 win (right column)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });

      test('detects main diagonal win (top-left to bottom-right)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });

      test('detects anti-diagonal win (top-right to bottom-left)', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: null),
            const CellState(owner: Player.playerOne),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.wonByPlayerTwo);
      });
    });

    group('Tied boards', () {
      test('returns tied when all cells filled with no winner', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.tied);
      });
    });

    group('Active boards', () {
      test('returns active when board is empty', () {
        // Arrange
        final board = BoardState.initial();

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.active);
      });

      test('returns active when partially filled with no winner', () {
        // Arrange
        final board = BoardState.initial().copyWith(
          cells: [
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
            const CellState(owner: Player.playerOne),
            const CellState(owner: null),
            const CellState(owner: null),
            const CellState(owner: Player.playerTwo),
          ],
        );

        // Act
        final result = repository.checkBoardWinner(board);

        // Assert
        expect(result, BoardStatus.active);
      });
    });
  });

  group('checkGameWinner', () {
    group('Player One wins', () {
      test('detects row 0 win (top row)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });

      test('detects row 1 win (middle row)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });

      test('detects row 2 win (bottom row)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });

      test('detects column 0 win (left column)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });

      test('detects column 1 win (middle column)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });

      test('detects column 2 win (right column)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });

      test('detects main diagonal win (top-left to bottom-right)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });

      test('detects anti-diagonal win (top-right to bottom-left)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerOne);
      });
    });

    group('Player Two wins', () {
      test('detects row 0 win (top row)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });

      test('detects row 1 win (middle row)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });

      test('detects row 2 win (bottom row)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });

      test('detects column 0 win (left column)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });

      test('detects column 1 win (middle column)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });

      test('detects column 2 win (right column)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });

      test('detects main diagonal win (top-left to bottom-right)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });

      test('detects anti-diagonal win (top-right to bottom-left)', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.wonByPlayerTwo);
      });
    });

    group('Tied games', () {
      test('returns tied when all boards finished with no three-in-a-row', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.tied),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.tied);
      });

      test('returns tied when all boards are tied', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: List.generate(
            9,
            (_) => BoardState.initial().copyWith(status: BoardStatus.tied),
          ),
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.tied);
      });

      test('returns tied when mix of won and tied boards with no three-in-a-row', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.tied),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.tied);
      });
    });

    group('Game in progress', () {
      test('returns inProgress when game is empty', () {
        // Arrange
        final state = GameState.initial();

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.inProgress);
      });

      test('returns inProgress when some boards are still active', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.tied),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.inProgress);
      });

      test('returns inProgress when no three-in-a-row and boards still playable', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.inProgress);
      });

      test('returns inProgress even when pattern matches but status is not a win', () {
        // Arrange - all three boards are tied (not a win)
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.inProgress);
      });

      test('returns inProgress when pattern matches active status', () {
        // Arrange - all three boards are active (not a win)
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.active),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.tied),
          ],
        );

        // Act
        final result = repository.checkGameWinner(state);

        // Assert
        expect(result, GameResult.inProgress);
      });
    });
  });
}
