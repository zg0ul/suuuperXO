// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardStateImpl _$$BoardStateImplFromJson(Map<String, dynamic> json) =>
    _$BoardStateImpl(
      cells: (json['cells'] as List<dynamic>)
          .map((e) => CellState.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$BoardStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$BoardStateImplToJson(_$BoardStateImpl instance) =>
    <String, dynamic>{
      'cells': instance.cells,
      'status': _$BoardStatusEnumMap[instance.status]!,
    };

const _$BoardStatusEnumMap = {
  BoardStatus.active: 'active',
  BoardStatus.wonByPlayerOne: 'wonByPlayerOne',
  BoardStatus.wonByPlayerTwo: 'wonByPlayerTwo',
  BoardStatus.tied: 'tied',
};
