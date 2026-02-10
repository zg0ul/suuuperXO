// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BoardState _$BoardStateFromJson(Map<String, dynamic> json) {
  return _BoardState.fromJson(json);
}

/// @nodoc
mixin _$BoardState {
  List<CellState> get cells =>
      throw _privateConstructorUsedError; // Always 9 cells
  BoardStatus get status => throw _privateConstructorUsedError;

  /// Serializes this BoardState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoardStateCopyWith<BoardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardStateCopyWith<$Res> {
  factory $BoardStateCopyWith(
    BoardState value,
    $Res Function(BoardState) then,
  ) = _$BoardStateCopyWithImpl<$Res, BoardState>;
  @useResult
  $Res call({List<CellState> cells, BoardStatus status});
}

/// @nodoc
class _$BoardStateCopyWithImpl<$Res, $Val extends BoardState>
    implements $BoardStateCopyWith<$Res> {
  _$BoardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cells = null, Object? status = null}) {
    return _then(
      _value.copyWith(
            cells: null == cells
                ? _value.cells
                : cells // ignore: cast_nullable_to_non_nullable
                      as List<CellState>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BoardStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BoardStateImplCopyWith<$Res>
    implements $BoardStateCopyWith<$Res> {
  factory _$$BoardStateImplCopyWith(
    _$BoardStateImpl value,
    $Res Function(_$BoardStateImpl) then,
  ) = __$$BoardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CellState> cells, BoardStatus status});
}

/// @nodoc
class __$$BoardStateImplCopyWithImpl<$Res>
    extends _$BoardStateCopyWithImpl<$Res, _$BoardStateImpl>
    implements _$$BoardStateImplCopyWith<$Res> {
  __$$BoardStateImplCopyWithImpl(
    _$BoardStateImpl _value,
    $Res Function(_$BoardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cells = null, Object? status = null}) {
    return _then(
      _$BoardStateImpl(
        cells: null == cells
            ? _value._cells
            : cells // ignore: cast_nullable_to_non_nullable
                  as List<CellState>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BoardStatus,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardStateImpl implements _BoardState {
  const _$BoardStateImpl({
    required final List<CellState> cells,
    required this.status,
  }) : _cells = cells;

  factory _$BoardStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardStateImplFromJson(json);

  final List<CellState> _cells;
  @override
  List<CellState> get cells {
    if (_cells is EqualUnmodifiableListView) return _cells;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cells);
  }

  // Always 9 cells
  @override
  final BoardStatus status;

  @override
  String toString() {
    return 'BoardState(cells: $cells, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardStateImpl &&
            const DeepCollectionEquality().equals(other._cells, _cells) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_cells),
    status,
  );

  /// Create a copy of BoardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardStateImplCopyWith<_$BoardStateImpl> get copyWith =>
      __$$BoardStateImplCopyWithImpl<_$BoardStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardStateImplToJson(this);
  }
}

abstract class _BoardState implements BoardState {
  const factory _BoardState({
    required final List<CellState> cells,
    required final BoardStatus status,
  }) = _$BoardStateImpl;

  factory _BoardState.fromJson(Map<String, dynamic> json) =
      _$BoardStateImpl.fromJson;

  @override
  List<CellState> get cells; // Always 9 cells
  @override
  BoardStatus get status;

  /// Create a copy of BoardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardStateImplCopyWith<_$BoardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
