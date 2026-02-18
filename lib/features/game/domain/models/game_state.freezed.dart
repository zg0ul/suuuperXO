// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  List<BoardState> get boards =>
      throw _privateConstructorUsedError; // 9 small boards
  Player get currentPlayer => throw _privateConstructorUsedError;
  int? get nextBoardIndex =>
      throw _privateConstructorUsedError; // null = can play anywhere
  GameStatus get status => throw _privateConstructorUsedError;
  GameResult get result => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastMoveAt => throw _privateConstructorUsedError;
  GameMode get mode => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call({
    List<BoardState> boards,
    Player currentPlayer,
    int? nextBoardIndex,
    GameStatus status,
    GameResult result,
    DateTime createdAt,
    DateTime? lastMoveAt,
    GameMode mode,
    bool isOnline,
  });
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boards = null,
    Object? currentPlayer = null,
    Object? nextBoardIndex = freezed,
    Object? status = null,
    Object? result = null,
    Object? createdAt = null,
    Object? lastMoveAt = freezed,
    Object? mode = null,
    Object? isOnline = null,
  }) {
    return _then(
      _value.copyWith(
            boards: null == boards
                ? _value.boards
                : boards // ignore: cast_nullable_to_non_nullable
                      as List<BoardState>,
            currentPlayer: null == currentPlayer
                ? _value.currentPlayer
                : currentPlayer // ignore: cast_nullable_to_non_nullable
                      as Player,
            nextBoardIndex: freezed == nextBoardIndex
                ? _value.nextBoardIndex
                : nextBoardIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GameStatus,
            result: null == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as GameResult,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastMoveAt: freezed == lastMoveAt
                ? _value.lastMoveAt
                : lastMoveAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as GameMode,
            isOnline: null == isOnline
                ? _value.isOnline
                : isOnline // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
    _$GameStateImpl value,
    $Res Function(_$GameStateImpl) then,
  ) = __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<BoardState> boards,
    Player currentPlayer,
    int? nextBoardIndex,
    GameStatus status,
    GameResult result,
    DateTime createdAt,
    DateTime? lastMoveAt,
    GameMode mode,
    bool isOnline,
  });
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
    _$GameStateImpl _value,
    $Res Function(_$GameStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boards = null,
    Object? currentPlayer = null,
    Object? nextBoardIndex = freezed,
    Object? status = null,
    Object? result = null,
    Object? createdAt = null,
    Object? lastMoveAt = freezed,
    Object? mode = null,
    Object? isOnline = null,
  }) {
    return _then(
      _$GameStateImpl(
        boards: null == boards
            ? _value._boards
            : boards // ignore: cast_nullable_to_non_nullable
                  as List<BoardState>,
        currentPlayer: null == currentPlayer
            ? _value.currentPlayer
            : currentPlayer // ignore: cast_nullable_to_non_nullable
                  as Player,
        nextBoardIndex: freezed == nextBoardIndex
            ? _value.nextBoardIndex
            : nextBoardIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GameStatus,
        result: null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as GameResult,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastMoveAt: freezed == lastMoveAt
            ? _value.lastMoveAt
            : lastMoveAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as GameMode,
        isOnline: null == isOnline
            ? _value.isOnline
            : isOnline // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl implements _GameState {
  const _$GameStateImpl({
    required final List<BoardState> boards,
    required this.currentPlayer,
    required this.nextBoardIndex,
    required this.status,
    required this.result,
    required this.createdAt,
    required this.lastMoveAt,
    required this.mode,
    this.isOnline = false,
  }) : _boards = boards;

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  final List<BoardState> _boards;
  @override
  List<BoardState> get boards {
    if (_boards is EqualUnmodifiableListView) return _boards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boards);
  }

  // 9 small boards
  @override
  final Player currentPlayer;
  @override
  final int? nextBoardIndex;
  // null = can play anywhere
  @override
  final GameStatus status;
  @override
  final GameResult result;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastMoveAt;
  @override
  final GameMode mode;
  @override
  @JsonKey()
  final bool isOnline;

  @override
  String toString() {
    return 'GameState(boards: $boards, currentPlayer: $currentPlayer, nextBoardIndex: $nextBoardIndex, status: $status, result: $result, createdAt: $createdAt, lastMoveAt: $lastMoveAt, mode: $mode, isOnline: $isOnline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            const DeepCollectionEquality().equals(other._boards, _boards) &&
            (identical(other.currentPlayer, currentPlayer) ||
                other.currentPlayer == currentPlayer) &&
            (identical(other.nextBoardIndex, nextBoardIndex) ||
                other.nextBoardIndex == nextBoardIndex) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMoveAt, lastMoveAt) ||
                other.lastMoveAt == lastMoveAt) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_boards),
    currentPlayer,
    nextBoardIndex,
    status,
    result,
    createdAt,
    lastMoveAt,
    mode,
    isOnline,
  );

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(this);
  }
}

abstract class _GameState implements GameState {
  const factory _GameState({
    required final List<BoardState> boards,
    required final Player currentPlayer,
    required final int? nextBoardIndex,
    required final GameStatus status,
    required final GameResult result,
    required final DateTime createdAt,
    required final DateTime? lastMoveAt,
    required final GameMode mode,
    final bool isOnline,
  }) = _$GameStateImpl;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  List<BoardState> get boards; // 9 small boards
  @override
  Player get currentPlayer;
  @override
  int? get nextBoardIndex; // null = can play anywhere
  @override
  GameStatus get status;
  @override
  GameResult get result;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastMoveAt;
  @override
  GameMode get mode;
  @override
  bool get isOnline;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
