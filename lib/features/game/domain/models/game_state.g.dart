// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      boards: (json['boards'] as List<dynamic>)
          .map((e) => BoardState.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPlayer: $enumDecode(_$PlayerEnumMap, json['currentPlayer']),
      winner: $enumDecodeNullable(_$PlayerEnumMap, json['winner']),
      nextBoardIndex: (json['nextBoardIndex'] as num?)?.toInt(),
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastMoveAt: json['lastMoveAt'] == null
          ? null
          : DateTime.parse(json['lastMoveAt'] as String),
      mode: $enumDecode(_$GameModeEnumMap, json['mode']),
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'boards': instance.boards,
      'currentPlayer': _$PlayerEnumMap[instance.currentPlayer]!,
      'winner': _$PlayerEnumMap[instance.winner],
      'nextBoardIndex': instance.nextBoardIndex,
      'status': _$GameStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastMoveAt': instance.lastMoveAt?.toIso8601String(),
      'mode': _$GameModeEnumMap[instance.mode]!,
      'isOnline': instance.isOnline,
    };

const _$PlayerEnumMap = {
  Player.playerOne: 'playerOne',
  Player.playerTwo: 'playerTwo',
};

const _$GameStatusEnumMap = {
  GameStatus.waiting: 'waiting',
  GameStatus.playing: 'playing',
  GameStatus.finished: 'finished',
  GameStatus.abandoned: 'abandoned',
};

const _$GameModeEnumMap = {
  GameMode.classic: 'classic',
  GameMode.wild: 'wild',
  GameMode.speed: 'speed',
  GameMode.tournament: 'tournament',
};
