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

  group('makeMove', () {
    test('marks cell with current player', () {
      // Arrange
      final state = GameState.initial();
      expect(state.currentPlayer, Player.playerOne);

      // Act
      final result = repository.makeMove(state, 0, 4);

      // Assert
      expect(result.boards[0].cells[4].owner, Player.playerOne);
      expect(state.boards[0].cells[4].owner, null); // Original unchanged
    });

    test('switches to next player after move', () {
      // Arrange
      final state = GameState.initial();
      expect(state.currentPlayer, Player.playerOne);

      // Act
      final result = repository.makeMove(state, 0, 0);

      // Assert
      expect(result.currentPlayer, Player.playerTwo);
    });

    test('updates lastMoveAt timestamp', () {
      // Arrange
      final state = GameState.initial();
      final beforeMove = DateTime.now();

      // Act
      final result = repository.makeMove(state, 0, 0);

      // Assert
      expect(result.lastMoveAt, isNotNull);
      expect(result.lastMoveAt!.isAfter(beforeMove), true);
    });

    test('does not modify original state', () {
      // Arrange
      final state = GameState.initial();
      final originalBoards = state.boards;
      final originalPlayer = state.currentPlayer;
      final originalNextBoard = state.nextBoardIndex;

      // Act
      final result = repository.makeMove(state, 0, 4);

      // Assert
      expect(state.boards, originalBoards);
      expect(state.currentPlayer, originalPlayer);
      expect(state.nextBoardIndex, originalNextBoard);
      expect(result.boards[0].cells[4].owner, Player.playerOne);
    });

    group('nextBoardIndex calculation', () {
      test('sets nextBoardIndex to cellIndex when target board is active', () {
        // Arrange
        final state = GameState.initial();

        // Act
        final result = repository.makeMove(state, 0, 5);

        // Assert
        expect(result.nextBoardIndex, 5);
      });

      test('sets nextBoardIndex to null when target board is won', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial(),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            ...List.generate(7, (_) => BoardState.initial()),
          ],
        );

        // Act - play in cell 1, which points to board 1 (already won)
        final result = repository.makeMove(state, 0, 1);

        // Assert
        expect(result.nextBoardIndex, null);
      });

      test('sets nextBoardIndex to null when target board is tied', () {
        // Arrange
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial(),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            ...List.generate(7, (_) => BoardState.initial()),
          ],
        );

        // Act - play in cell 1, which points to board 1 (already tied)
        final result = repository.makeMove(state, 0, 1);

        // Assert
        expect(result.nextBoardIndex, null);
      });

      test('sets nextBoardIndex correctly for each cell index', () {
        // Arrange
        final state = GameState.initial();

        // Act & Assert
        for (int cellIndex = 0; cellIndex < 9; cellIndex++) {
            final result = repository.makeMove(state, 0, cellIndex);
          expect(result.nextBoardIndex, cellIndex);
        }
      });
    });

    group('board status updates', () {
      test('keeps board active when move does not create win or tie', () {
        // Arrange
        final state = GameState.initial();

        // Act
        final result = repository.makeMove(state, 0, 0);

        // Assert
        expect(result.boards[0].status, BoardStatus.active);
      });

      test('updates board to wonByPlayerOne when player one wins', () {
        // Arrange - Player One needs two more moves to win row 0
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(
              cells: [
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerOne),
                const CellState(owner: null),
                ...List.generate(6, (_) => CellState.initial()),
              ],
            ),
            ...List.generate(8, (_) => BoardState.initial()),
          ],
        );

        // Act - Player One completes the row
        final result = repository.makeMove(state, 0, 2);

        // Assert
        expect(result.boards[0].status, BoardStatus.wonByPlayerOne);
      });

      test('updates board to wonByPlayerTwo when player two wins', () {
        // Arrange - Player Two needs two more moves to win column 0
        final state = GameState.initial().copyWith(
          currentPlayer: Player.playerTwo,
          boards: [
            BoardState.initial().copyWith(
              cells: [
                const CellState(owner: Player.playerTwo),
                const CellState(owner: null),
                const CellState(owner: null),
                const CellState(owner: Player.playerTwo),
                ...List.generate(5, (_) => CellState.initial()),
              ],
            ),
            ...List.generate(8, (_) => BoardState.initial()),
          ],
        );

        // Act - Player Two completes the column
        final result = repository.makeMove(state, 0, 6);

        // Assert
        expect(result.boards[0].status, BoardStatus.wonByPlayerTwo);
      });

      test('updates board to tied when all cells filled with no winner', () {
        // Arrange - Board with 8 cells filled, no winner
        // Layout ensures no win when cell 8 is filled by Player One
        // Must avoid: rows [0,1,2], [3,4,5], [6,7,8]
        //            columns [0,3,6], [1,4,7], [2,5,8]
        //            diagonals [0,4,8], [2,4,6]
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(
              cells: [
                const CellState(owner: Player.playerTwo), // Changed to prevent diagonal [0,4,8] win
                const CellState(owner: Player.playerTwo),
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerTwo),
                const CellState(owner: Player.playerTwo),
                const CellState(owner: Player.playerOne),
                const CellState(owner: null), // Last empty cell
              ],
            ),
            ...List.generate(8, (_) => BoardState.initial()),
          ],
        );

        // Act - Fill the last cell
        final result = repository.makeMove(state, 0, 8);

        // Assert
        expect(result.boards[0].status, BoardStatus.tied);
      });
    });

    group('game result updates', () {
      test('keeps game inProgress when no meta-board win', () {
        // Arrange
        final state = GameState.initial();

        // Act
        final result = repository.makeMove(state, 0, 0);

        // Assert
        expect(result.result, GameResult.inProgress);
      });

      test('updates game to wonByPlayerOne when player one wins meta-board', () {
        // Arrange - Player One has won boards 0 and 1, needs board 2
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(
              cells: [
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerOne),
                const CellState(owner: null),
                ...List.generate(6, (_) => CellState.initial()),
              ],
            ),
            ...List.generate(6, (_) => BoardState.initial()),
          ],
        );

        // Act - Player One wins board 2, completing the row
        final result = repository.makeMove(state, 2, 2);

        // Assert
        expect(result.result, GameResult.wonByPlayerOne);
        expect(result.boards[2].status, BoardStatus.wonByPlayerOne);
      });

      test('updates game to wonByPlayerTwo when player two wins meta-board', () {
        // Arrange - Player Two has won boards 0 and 3, needs board 6 (column 0)
        final state = GameState.initial().copyWith(
          currentPlayer: Player.playerTwo,
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial(),
            BoardState.initial(),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial(),
            BoardState.initial(),
            BoardState.initial().copyWith(
              cells: [
                const CellState(owner: Player.playerTwo),
                const CellState(owner: null),
                const CellState(owner: null),
                const CellState(owner: Player.playerTwo),
                ...List.generate(5, (_) => CellState.initial()),
              ],
            ),
            BoardState.initial(),
            BoardState.initial(),
          ],
        );

        // Act - Player Two wins board 6, completing the column
        final result = repository.makeMove(state, 6, 6);

        // Assert
        expect(result.result, GameResult.wonByPlayerTwo);
        expect(result.boards[6].status, BoardStatus.wonByPlayerTwo);
      });

      test('updates game to tied when all boards finished with no meta-win', () {
        // Arrange - 8 boards finished, board 8 needs to be tied
        // Ensure no meta-win: avoid three-in-a-row patterns
        // Meta-board layout: [P1, P2, T, P2, P1, T, P2, P1, ?]
        // Check patterns:
        // - Row 0 [0,1,2]: P1, P2, T - no win
        // - Row 1 [3,4,5]: P2, P1, T - no win
        // - Row 2 [6,7,8]: P2, P1, ? - no win (will be tied)
        // - Column 0 [0,3,6]: P1, P2, P2 - no win
        // - Column 1 [1,4,7]: P2, P1, P1 - no win
        // - Column 2 [2,5,8]: T, T, ? - no win (will be tied)
        // - Diagonal [0,4,8]: P1, P1, ? - no win (will be tied)
        // - Anti-diagonal [2,4,6]: T, P1, P2 - no win
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(status: BoardStatus.tied),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerTwo),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial().copyWith(
              cells: [
                const CellState(owner: Player.playerTwo), // Changed to prevent diagonal [0,4,8] win
                const CellState(owner: Player.playerTwo),
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerTwo),
                const CellState(owner: Player.playerTwo),
                const CellState(owner: Player.playerOne),
                const CellState(owner: null), // Last empty cell
              ],
            ),
          ],
        );

        // Act - Fill the last cell, tying board 8
        final result = repository.makeMove(state, 8, 8);

        // Assert
        expect(result.result, GameResult.tied);
        expect(result.boards[8].status, BoardStatus.tied);
      });
    });

    group('multiple moves in sequence', () {
      test('applies multiple moves correctly', () {
        // Arrange
        var state = GameState.initial();

        // Act - Player One plays
        state = repository.makeMove(state, 0, 0);
        expect(state.currentPlayer, Player.playerTwo);
        expect(state.boards[0].cells[0].owner, Player.playerOne);
        expect(state.nextBoardIndex, 0);

        // Player Two plays
        state = repository.makeMove(state, 0, 1);
        expect(state.currentPlayer, Player.playerOne);
        expect(state.boards[0].cells[1].owner, Player.playerTwo);
        expect(state.nextBoardIndex, 1);

        // Player One plays
        state = repository.makeMove(state, 1, 4);
        expect(state.currentPlayer, Player.playerTwo);
        expect(state.boards[1].cells[4].owner, Player.playerOne);
        expect(state.nextBoardIndex, 4);
      });

      test('handles player switching correctly through multiple moves', () {
        // Arrange
        var state = GameState.initial();

        // Act & Assert
        for (int i = 0; i < 5; i++) {
          final expectedPlayer = i.isEven ? Player.playerOne : Player.playerTwo;
          expect(state.currentPlayer, expectedPlayer);

          state = repository.makeMove(state, i % 9, i % 9);

          final nextExpectedPlayer = i.isEven ? Player.playerTwo : Player.playerOne;
          expect(state.currentPlayer, nextExpectedPlayer);
        }
      });
    });

    group('edge cases', () {
      test('handles move in different boards correctly', () {
        // Arrange
        final state = GameState.initial();

        // Act
        final result = repository.makeMove(state, 5, 3);

        // Assert
        expect(result.boards[5].cells[3].owner, Player.playerOne);
        expect(result.boards[0].cells[0].owner, null); // Other board unchanged
      });

      test('handles move when nextBoardIndex constraint exists', () {
        // Arrange
        final state = GameState.initial().copyWith(
          nextBoardIndex: 3,
        );

        // Act - Play in the required board
        final result = repository.makeMove(state, 3, 7);

        // Assert
        expect(result.boards[3].cells[7].owner, Player.playerOne);
        expect(result.nextBoardIndex, 7); // Next board is determined by cell index
      });

      test('handles move that completes a board and determines next board', () {
        // Arrange - Player One about to win board 0
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial().copyWith(
              cells: [
                const CellState(owner: Player.playerOne),
                const CellState(owner: Player.playerOne),
                const CellState(owner: null),
                ...List.generate(6, (_) => CellState.initial()),
              ],
            ),
            ...List.generate(8, (_) => BoardState.initial()),
          ],
        );

        // Act - Player One wins board 0 by playing cell 2
        final result = repository.makeMove(state, 0, 2);

        // Assert
        expect(result.boards[0].status, BoardStatus.wonByPlayerOne);
        expect(result.nextBoardIndex, 2); // Next board is 2 (from cell index)
        expect(result.currentPlayer, Player.playerTwo);
      });

      test('handles move that sends opponent to already-won board', () {
        // Arrange - Board 4 is already won
        final state = GameState.initial().copyWith(
          boards: [
            BoardState.initial(),
            BoardState.initial(),
            BoardState.initial(),
            BoardState.initial(),
            BoardState.initial().copyWith(status: BoardStatus.wonByPlayerOne),
            BoardState.initial(),
            BoardState.initial(),
            BoardState.initial(),
            BoardState.initial(),
          ],
        );

        // Act - Play in cell 4, which points to board 4 (already won)
        final result = repository.makeMove(state, 0, 4);

        // Assert
        expect(result.nextBoardIndex, null); // Opponent can choose any board
      });
    });
  });
}
