import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';
import 'package:suuuperxo/features/game/domain/models/board_state.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum GameStatus {
  waiting, // Waiting for second player (online)
  playing, // Game in progress
  abandoned, // Player disconnected/quit
}

enum GameResult {
  inProgress, // Game still being played
  wonByPlayerOne, // Player One won
  wonByPlayerTwo, // Player Two won
  tied, // No winner possible
}

enum GameMode { classic, wild, speed, tournament }

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required List<BoardState> boards, // 9 small boards
    required Player currentPlayer,
    required int? nextBoardIndex, // null = can play anywhere
    required GameStatus status,
    required GameResult result,
    required DateTime createdAt,
    required DateTime? lastMoveAt,
    required GameMode mode,
    @Default(false) bool isOnline,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

  factory GameState.initial() => GameState(
        boards: List.generate(9, (index) => BoardState.initial()),
        currentPlayer: Player.playerOne,
        nextBoardIndex: null,
        status: GameStatus.playing,
        result: GameResult.inProgress,
        createdAt: DateTime.now(),
        lastMoveAt: DateTime.now(),
        mode: GameMode.classic,
        isOnline: false,
      );
}
