import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';
import 'package:suuuperxo/features/game/domain/models/board_state.dart';
import 'package:suuuperxo/features/game/domain/models/cell_state.dart';
import 'package:suuuperxo/features/game/domain/models/game_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_repository.g.dart';

@riverpod
GameRepository gameRepository(Ref ref) {
  return GameRepository();
}

class GameRepository {
  static const List<List<int>> _winningPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
    [0, 4, 8], [2, 4, 6], // diagonals
  ];

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
    if (state.status != GameStatus.playing || state.result != GameResult.inProgress) {
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

  /// Determines the current status of a small board.
  ///
  /// Checks all possible winning patterns (3 rows, 3 columns, 2 diagonals)
  /// to determine if either player has won the board, if it's tied, or still active.
  ///
  /// Returns:
  /// - [BoardStatus.wonByPlayerOne] if Player One has three in a row
  /// - [BoardStatus.wonByPlayerTwo] if Player Two has three in a row
  /// - [BoardStatus.tied] if all 9 cells are filled with no winner
  /// - [BoardStatus.active] if the board still has empty cells and no winner
  ///
  /// This method is used for both:
  /// 1. Checking individual small boards within the meta-board
  /// 2. Checking the meta-board itself (by treating board statuses as "cells")
  BoardStatus checkBoardWinner(BoardState board) {
    // Check all 8 possible winning patterns
    for (final pattern in _winningPatterns) {
      final [a, b, c] = pattern;
      final (ownerA, ownerB, ownerC) = (board.cells[a].owner, board.cells[b].owner, board.cells[c].owner);

      // Three in a row: all cells owned by same player (not empty)
      if (ownerA != null && ownerA == ownerB && ownerA == ownerC) {
        return ownerA == Player.playerOne ? BoardStatus.wonByPlayerOne : BoardStatus.wonByPlayerTwo;
      }
    }

    // No winner found - determine if tied or still playable
    final allCellsFilled = board.cells.every((cell) => cell.owner != null);
    return allCellsFilled ? BoardStatus.tied : BoardStatus.active;
  }

  /// Determines the current result of the game by checking the meta-board.
  ///
  /// Checks all possible winning patterns (3 rows, 3 columns, 2 diagonals)
  /// on the meta-board to determine if either player has won three boards in a row.
  ///
  /// A game is considered tied when all 9 boards are in a finished state
  /// (wonByPlayerOne, wonByPlayerTwo, or tied) and no player has three in a row.
  ///
  /// Returns:
  /// - [GameResult.wonByPlayerOne] if Player One has won three boards in a row
  /// - [GameResult.wonByPlayerTwo] if Player Two has won three boards in a row
  /// - [GameResult.tied] if all boards are finished with no three-in-a-row
  /// - [GameResult.inProgress] if the game is still being played
  ///
  /// Note: This method checks the meta-board status, not individual cells.
  /// A board must be fully won (via [checkBoardWinner]) to count toward
  /// a meta-board win.
  GameResult checkGameWinner(GameState state) {
    // Check all 8 possible winning patterns on the meta-board
    for (final pattern in _winningPatterns) {
      final [a, b, c] = pattern;
      final (statusA, statusB, statusC) = (state.boards[a].status, state.boards[b].status, state.boards[c].status);

      // Check if all three boards have matching status AND it's a win status
      if (statusA == statusB && statusB == statusC) {
        if (statusA == BoardStatus.wonByPlayerOne) {
          return GameResult.wonByPlayerOne;
        }
        if (statusA == BoardStatus.wonByPlayerTwo) {
          return GameResult.wonByPlayerTwo;
        }
        // If all three are tied or active, continue checking other patterns
      }
    }

    // No three-in-a-row found - check if game is tied or still active
    final allBoardsFinished = state.boards.every((board) => board.status != BoardStatus.active);

    return allBoardsFinished ? GameResult.tied : GameResult.inProgress;
  }

  /// Applies a move and returns a new game state.
  ///
  /// This is a PURE function - it does not modify the input [state].
  /// Instead, it creates and returns a completely new [GameState] object
  /// with the move applied. The original state remains unchanged.
  ///
  /// **Prerequisites:**
  /// - The move MUST be validated using [isValidMove] before calling this method
  /// - This method assumes the move is legal and will apply it unconditionally
  ///
  /// **Operations Performed:**
  /// 1. **Mark Cell**: Sets the target cell's owner to the current player
  /// 2. **Check Board Status**: Determines if the board is won, tied, or active
  /// 3. **Calculate Next Board**: Determines where opponent must play next
  /// 4. **Check Game Status**: Determines if the game is won, tied, or continues
  /// 5. **Switch Player**: Changes to the next player
  /// 6. **Update Timestamp**: Records the move time
  ///
  /// **The "Next Board" Rule:**
  /// The cell you play in determines which board your opponent plays on next:
  /// - Play in cell 4 → opponent must play on board 4
  /// - Play in cell 7 → opponent must play on board 7
  /// - If that board is completed → opponent can choose any active board (null)
  ///
  /// Example:
  /// ```dart
  /// final oldState = GameState.initial();
  /// final newState = repo.makeMove(oldState, boardIndex: 0, cellIndex: 4);
  ///
  /// // oldState is unchanged
  /// // newState has the move applied
  /// ```
  ///
  /// Parameters:
  /// - [state]: Current game state (will NOT be modified)
  /// - [boardIndex]: Board to play on (0-8)
  /// - [cellIndex]: Cell within that board (0-8)
  ///
  /// Returns: New [GameState] with the move applied
  GameState makeMove(GameState state, int boardIndex, int cellIndex) {
    // Create a mutable working copy of the boards list
    final updatedBoards = List<BoardState>.from(state.boards);

    // Get the board that's being played on
    final targetBoard = updatedBoards[boardIndex];

    // Create a mutable copy of that board's cells
    final updatedCells = List<CellState>.from(targetBoard.cells);

    // Mark the played cell with current player's symbol
    updatedCells[cellIndex] = updatedCells[cellIndex].copyWith(owner: state.currentPlayer);

    // Create new BoardState with updated cells
    final updatedBoard = targetBoard.copyWith(cells: updatedCells);

    // Check if this board is now won, tied, or still active
    final newBoardStatus = checkBoardWinner(updatedBoard);

    // Update the board's status and put it back in the boards list
    updatedBoards[boardIndex] = updatedBoard.copyWith(status: newBoardStatus);

    // Determine where opponent must play next
    // Rule: The cell index determines the next board index
    final potentialNextBoard = cellIndex; // Cell 0→Board 0, Cell 4→Board 4, etc.

    // Check if that board is actually playable
    // If opponent is sent to a won/tied board, they can choose any active board
    final targetBoardStatus = updatedBoards[potentialNextBoard].status;
    final nextBoardIndex = targetBoardStatus == BoardStatus.active
        ? potentialNextBoard // Opponent must play on this specific board
        : null; // Opponent can choose any active board

    // Check if the game is now won or tied
    final intermediateState = state.copyWith(boards: updatedBoards);
    final gameResult = checkGameWinner(intermediateState);

    // Toggle to next player
    final nextPlayer = state.currentPlayer == Player.playerOne ? Player.playerTwo : Player.playerOne;

    // Return completely new GameState with all changes
    return state.copyWith(
      boards: updatedBoards,
      currentPlayer: nextPlayer,
      nextBoardIndex: nextBoardIndex,
      result: gameResult,
      lastMoveAt: DateTime.now(),
    );
  }
}
