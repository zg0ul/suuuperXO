import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:suuuperxo/features/game/domain/enums/player_enum.dart';

part 'cell_state.freezed.dart';
part 'cell_state.g.dart';

@freezed
abstract class CellState with _$CellState {
  const factory CellState({
    required Player? owner, // null means empty
  }) = _CellState;

  factory CellState.fromJson(Map<String, dynamic> json) => _$CellStateFromJson(json);

  factory CellState.initial() => const CellState(owner: null);
}
