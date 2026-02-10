import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';
import 'package:suuuperxo/features/game/domain/models/board_state.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum GameStatus {
  waiting, // Waiting for second player (online)
  playing, // Game in progress
  finished, // Game completed normally
  abandoned, // Player disconnected/quit
}

enum GameMode { classic, wild, speed, tournament }

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required List<BoardState> boards, // 9 small boards
    required Player currentPlayer,
    required Player? winner, // null means game is not finished yet
    required int? nextBoardIndex, // null = can play anywhere
    required GameStatus status,
    required DateTime createdAt,
    required DateTime? lastMoveAt,
    required GameMode mode,
    @Default(false) bool isOnline,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
}
