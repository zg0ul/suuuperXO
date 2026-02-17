import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';
import 'package:suuuperxo/features/game/domain/models/board_state.dart';
import 'package:suuuperxo/features/game/domain/models/game_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_repository.g.dart';

@riverpod
GameRepository gameRepository(Ref ref) {
  return GameRepository();
}

class GameRepository {
  /// Validates whether a move is legal according to Ultimate Tic Tac Toe rules.
  ///
  /// Checks four core validation rules:
  /// 1. Game must be in [GameStatus.playing] state with no winner
  /// 2. Target cell must be unoccupied (owner is null)
  /// 3. Target board must be [BoardStatus.active]
  /// 4. Move must respect [GameState.nextBoardIndex] constraint when applicable
  ///
  /// The [nextBoardIndex] constraint follows the "completed board" rule:
  /// - If [nextBoardIndex] is null, player may choose any active board
  /// - If [nextBoardIndex] points to an active board, player must play there
  /// - If [nextBoardIndex] points to a completed board (won/tied), player may
  ///   choose any active board
  ///
  /// Example:
  /// ```dart
  /// final state = GameState.initial();
  /// final isValid = repo.isValidMove(state, boardIndex: 0, cellIndex: 4);
  /// if (isValid) {
  ///   // Apply the move
  /// }
  /// ```
  ///
  /// Returns `true` if the move is legal, `false` otherwise.
  ///
  /// See also:
  /// - [makeMove] for applying validated moves
  /// - [GameState.nextBoardIndex] for the board constraint mechanism
  bool isValidMove(GameState state, int boardIndex, int cellIndex) {
    // Check 1: Verify game is in progress
    // A finished or abandoned game cannot accept new moves
    if (state.status != GameStatus.playing || state.winner != null) {
      return false;
    }

    // Check 2: Verify target cell is empty
    // Cannot overwrite a cell already owned by a player
    if (state.boards[boardIndex].cells[cellIndex].owner != null) {
      return false;
    }

    // Check 3: Verify target board is playable
    // Cannot play in boards that are already won or tied
    if (state.boards[boardIndex].status != BoardStatus.active) {
      return false;
    }

    // Check 4: Enforce nextBoardIndex constraint (Ultimate Tic Tac Toe rule)
    // "Where you play determines where your opponent plays next"
    if (state.nextBoardIndex != null) {
      final targetBoard = state.boards[state.nextBoardIndex!];

      // Only enforce the constraint if the target board is still playable
      // If sent to a completed board, player may choose any active board
      if (targetBoard.status == BoardStatus.active) {
        if (state.nextBoardIndex != boardIndex) {
          return false;
        }
      }
    }

    return true;
  }

  GameState makeMove(GameState state, int boardIndex, int cellIndex) {
    return state;
  }

  Player? checkBoardWinner(BoardState board) {
    return null;
  }
}
