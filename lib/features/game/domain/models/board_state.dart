import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suuuperxo/features/game/domain/models/cell_state.dart';

part 'board_state.freezed.dart';
part 'board_state.g.dart';

enum BoardStatus { active, wonByPlayerOne, wonByPlayerTwo, tied }

@freezed
class BoardState with _$BoardState {
  const factory BoardState({
    required List<CellState> cells, // Always 9 cells
    required BoardStatus status,
  }) = _BoardState;

  factory BoardState.fromJson(Map<String, dynamic> json) => _$BoardStateFromJson(json);

  factory BoardState.initial() => BoardState(
        cells: List.generate(9, (index) => CellState.initial()),
        status: BoardStatus.active,
      );
}
