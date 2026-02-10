// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CellStateImpl _$$CellStateImplFromJson(Map<String, dynamic> json) =>
    _$CellStateImpl(owner: $enumDecodeNullable(_$PlayerEnumMap, json['owner']));

Map<String, dynamic> _$$CellStateImplToJson(_$CellStateImpl instance) =>
    <String, dynamic>{'owner': _$PlayerEnumMap[instance.owner]};

const _$PlayerEnumMap = {
  Player.playerOne: 'playerOne',
  Player.playerTwo: 'playerTwo',
};
